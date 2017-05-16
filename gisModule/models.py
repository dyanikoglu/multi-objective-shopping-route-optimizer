from django.contrib.gis.db import models as gis_models
from django.contrib.gis import geos
from django.db import models
import json
import urllib3
import re
from urllib.parse import quote_plus

http = urllib3.PoolManager()


class City(models.Model):
    cityID = models.AutoField(primary_key=True)
    cityName = models.CharField("City Name", max_length=64, null=False)

    def __str__(self):
        return self.cityName


class District(models.Model):
    districtID = models.AutoField(primary_key=True)
    cityID = models.PositiveIntegerField("City ID")
    districtName = models.CharField("District Name", max_length=64, null=False)

    def __str__(self):
        return self.districtName


class RetailerType(models.Model):
    retailerTypeID = models.AutoField(primary_key=True)
    retailerTypeName = models.CharField("Retailer Type Name", max_length=128, null=False)

    def __str__(self):
        return self.retailerTypeName


class Retailer(models.Model):
    retailerName = models.CharField("Retailer Name", max_length=256, null=False)
    retailerType = models.ForeignKey(RetailerType, null=True)
    retailerID = models.AutoField(primary_key=True)
    address = models.CharField("Address", max_length=512)
    geoLocation = gis_models.PointField(geography=True, blank=True, null=True, editable=False)
    cityID = models.PositiveIntegerField(null=True, editable=False)
    districtID = models.PositiveIntegerField(null=True, editable=False)
    zipCode = models.CharField(max_length=8, editable=False, null=True)
    lastEditTime = models.DateTimeField(auto_now_add=True, blank=True, editable=False)

    gis = gis_models.GeoManager()
    objects = models.Manager()

    def __str__(self):
        return self.retailerName

    def save(self, **kwargs):
        results = http.request('GET', "http://maps.googleapis.com/maps/api/geocode/json?address=%s+%s" %
                               (quote_plus(self.address), quote_plus(self.retailerName)))
        js = json.loads(results.data.decode('utf-8'))
        lat_lng_regex = re.match(r'([0-9]+\.[0-9]+)( |, |,)([0-9]+\.[0-9]+)', self.address, flags=0)
        if lat_lng_regex is not None:
            results2 = http.request('GET', "http://maps.googleapis.com/maps/api/geocode/json?address=%s" %
                                    (quote_plus(self.address)))
            js2 = json.loads(results2.data.decode('utf-8'))
            if js2['status'] == "OK":
                point = "SRID=4326;POINT(%s %s)" % (str(lat_lng_regex.group(3)), str(lat_lng_regex.group(1)))
                self.geoLocation = geos.fromstr(point)

                address_components = js2['results'][0]['address_components']
                for component in address_components:
                    if component['types'][0] == "administrative_area_level_1":
                        self.cityID = int(City.objects.get(cityName=component['long_name']).cityID)
                    if component['types'][0] == "administrative_area_level_2":
                        self.districtID = int(District.objects.get(districtName=component['long_name']).districtID)
                    if component['types'][0] == "postal_code":
                        self.zipCode = component['long_name']

                self.address = js2['results'][0]['formatted_address']
            else:
                print("Valid address value should be supplied to the form")
                return
        elif js['status'] == "OK":
            parsed_latlng = js['results'][0]['geometry']['location']
            point = "SRID=4326;POINT(%s %s)" % (parsed_latlng['lng'], parsed_latlng['lat'])
            self.geoLocation = geos.fromstr(point)

            address_components = js['results'][0]['address_components']
            for component in address_components:
                if component['types'][0] == "administrative_area_level_1":
                    self.cityID = int(City.objects.get(cityName=component['long_name']).cityID)
                if component['types'][0] == "administrative_area_level_2":
                    self.districtID = int(District.objects.get(districtName=component['long_name']).districtID)
                if component['types'][0] == "postal_code":
                    self.zipCode = component['long_name']

            self.address = js['results'][0]['formatted_address']
        else:
            print("Valid address value should be supplied to the form")
            return
        super(Retailer, self).save()


class ProductGroup(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField("Product Group Name", max_length=128)
    parent = models.ForeignKey('ProductGroup', null=True, blank=True)

    def __str__(self):
        return self.name


class BaseProduct(models.Model):
    UNIT_CHOICES = (
        ('ML', 'Milliliters'),
        ('L', 'Liters'),
        ('KG', 'Kilograms'),
        ('G', 'Grams'),
        (' Units', 'Units'),
        (' Cans', 'Cans'),
    )

    group = models.ForeignKey('ProductGroup', null=True)
    productID = models.AutoField(primary_key=True)
    brand = models.CharField("Brand", max_length=64)
    type = models.CharField("Type", max_length=64, blank=True)
    amount = models.PositiveIntegerField("Amount")
    unit = models.CharField("Unit", choices=UNIT_CHOICES, max_length=8)
    name = models.CharField("Full Name", max_length=64, editable=False, null=True)

    def __str__(self):
        return "%s %s %s%s" % (self.brand, self.type, self.amount, self.unit)

    def save(self, **kwargs):
        self.name = "%s %s %s%s" % (self.brand, self.type, self.amount, self.unit)
        super(BaseProduct, self).save()


class RetailerProduct(models.Model):
    baseProduct = models.ForeignKey(BaseProduct, null=True)
    retailer = models.ForeignKey(Retailer, null=True)
    unitPrice = models.FloatField("Unit Price(₺)")
    lastEditTime = models.DateTimeField(auto_now_add=True, blank=True, editable=False)

    def __str__(self):
        product = BaseProduct.objects.get(productID=self.baseProduct.productID)
        retailer = Retailer.objects.get(retailerID=self.retailer.retailerID)
        return "%s | %s" % (retailer.retailerName, product)


class ShoppingList(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField("List Name", max_length=64, default="Shopping List")
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    completed = models.BooleanField("Completed?", default=False)

    def __str__(self):
        return "%s" % self.name


class User(models.Model):
    id = models.AutoField(primary_key=True)
    username = models.CharField("User Name", max_length=100)
    password = models.CharField("Password", max_length=512)
    first_name = models.CharField("First Name", max_length=64)
    last_name = models.CharField("Last Name", max_length=64)
    email = models.EmailField("Email", max_length=64, null=True)
    active_list = models.ForeignKey(ShoppingList, null="True", blank=True)
    preferences = models.ForeignKey('UserPreferences', null="True")

    def __str__(self):
        return self.username


class UserPreferences(models.Model):
    owner = models.ForeignKey('User', null=True)
    money_factor = models.BooleanField("Money Factor")
    dist_factor = models.BooleanField("Distance Factor")
    time_factor = models.BooleanField("Time Factor")
    search_radius = models.PositiveIntegerField("Search Radius(km)", null="True")
    route_start_point = models.ForeignKey('UserSavedAddress', related_name='StartAddress', null=True, blank=True)
    route_end_point = models.ForeignKey('UserSavedAddress', related_name='EndAddress', null=True, blank=True)
    get_notif_only_for_active_list = models.BooleanField("Get notifications only for active shopping list?", default=True)

    def __str__(self):
        return str(self.owner.username + "\'s Preferences")


class UserSavedAddress(models.Model):
    name = models.CharField("Address Name", max_length=256, null=False)
    id = models.AutoField(primary_key=True)
    user = models.ForeignKey(User, null=True)
    address = models.CharField("Address", max_length=512)
    geoLocation = gis_models.PointField(geography=True, blank=True, null=True, editable=False)
    city = models.ForeignKey(City, null=True, editable=False)
    district = models.ForeignKey(District, null=True, editable=False)
    zipcode = models.CharField(max_length=8, editable=False, null=True)
    last_edit_time = models.DateTimeField(auto_now_add=True, blank=True, editable=False)

    gis = gis_models.GeoManager()
    objects = models.Manager()

    def __str__(self):
        return self.user.username + ":" + self.name

    def save(self, **kwargs):
        results = http.request('GET',
                               "http://maps.googleapis.com/maps/api/geocode/json?address=%s" % quote_plus(self.address))
        js = json.loads(results.data.decode('utf-8'))
        lat_lng_regex = re.match(r'([0-9]+\.[0-9]+)( |, |,)([0-9]+\.[0-9]+)', self.address, flags=0)
        if lat_lng_regex is not None:
            results2 = http.request('GET', "http://maps.googleapis.com/maps/api/geocode/json?address=%s" %
                                    (quote_plus(self.address)))
            js2 = json.loads(results2.data.decode('utf-8'))
            if js2['status'] == "OK":
                point = "SRID=4326;POINT(%s %s)" % (str(lat_lng_regex.group(3)), str(lat_lng_regex.group(1)))
                self.geoLocation = geos.fromstr(point)

                address_components = js2['results'][0]['address_components']
                for component in address_components:
                    if component['types'][0] == "administrative_area_level_1":
                        self.city = City.objects.get(cityName=component['long_name'])
                    if component['types'][0] == "administrative_area_level_2":
                        self.district = District.objects.get(districtName=component['long_name'])
                    if component['types'][0] == "postal_code":
                        self.zipCode = component['long_name']

                self.address = js2['results'][0]['formatted_address']
            else:
                raise ValueError('Address is not valid')
        elif js['status'] == "OK":
            parsed_latlng = js['results'][0]['geometry']['location']
            point = "SRID=4326;POINT(%s %s)" % (parsed_latlng['lng'], parsed_latlng['lat'])
            self.geoLocation = geos.fromstr(point)

            address_components = js['results'][0]['address_components']
            for component in address_components:
                if component['types'][0] == "administrative_area_level_1":
                    self.city = City.objects.get(cityName=component['long_name'])
                if component['types'][0] == "administrative_area_level_2":
                    self.district = District.objects.get(districtName=component['long_name'])
                if component['types'][0] == "postal_code":
                    self.zipCode = component['long_name']

            self.address = js['results'][0]['formatted_address']
        else:
            raise ValueError('Address is not valid')
        super(UserSavedAddress, self).save()


class ShoppingListMember(models.Model):
    list = models.ForeignKey(ShoppingList, null=True)
    user = models.ForeignKey(User, null=True)
    role = models.ForeignKey('Role', null=True)

    def __str__(self):
        username = self.user.username
        list_name = self.list.name
        return "%s:%s" % (username, list_name)


class ShoppingListItem(models.Model):
    id = models.AutoField(primary_key=True)
    list = models.ForeignKey(ShoppingList, null=True)
    product = models.ForeignKey(BaseProduct, null=True)
    addedBy = models.ForeignKey(User, null=True, related_name='added_by')
    edited_by = models.ForeignKey(User, null=True, related_name='edited_by')
    quantity = models.PositiveIntegerField("Quantity")

    def __str__(self):
        return "%s:%s" % (self.list.name, self.product.brand)


class Friend(models.Model):
    id = models.AutoField(primary_key=True)
    user_sender = models.ForeignKey('User', null=True, related_name='user_sender')
    user_receiver = models.ForeignKey('User', null=True, related_name='user_receiver')
    status = models.BooleanField('Status', default=False)
    date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "%s - %s" % (self.user_sender.username, self.user_receiver.username)


class Group(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField('Group Name', max_length=64, null=True)
    date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name


class GroupMember(models.Model):
    id = models.AutoField(primary_key=True)
    group = models.ForeignKey('Group', null=True)
    member = models.ForeignKey('User', null=True)
    role = models.ForeignKey('Role', null=True)
    date = models.DateTimeField(auto_now_add=True, null=True)

    def __str__(self):
        return "%s - %s" % (self.group.name, self.member.username)


class Role(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField('Role Name', max_length=64, null=True)

    def __str__(self):
        return self.name
