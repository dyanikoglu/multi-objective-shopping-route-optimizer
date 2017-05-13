import json
from math import radians, sin, cos, degrees, acos
from django.contrib.gis import geos, measure
from django.core.exceptions import ObjectDoesNotExist
from django.http import HttpResponse
from gisModule import models
import googlemaps
import urllib3
from collections import OrderedDict
from passlib.hash import pbkdf2_sha256

gmaps = googlemaps.Client(key='AIzaSyAYuOUUDGueFxWz8Esal0CqWANHV2Z7YUI')
http = urllib3.PoolManager()


def bad_request(message):
    response = HttpResponse(json.dumps({'message': message}), content_type='application/json')
    response.status_code = 400
    return response


# Convert a python dictionary string to json format
def jsonify_dict(source):
    json_str = str(source).replace('\'', '\"')
    json_str = json_str.replace(': \"[', ': [')
    json_str = json_str.replace(': \"{', ': {')
    json_str = json_str.replace('}"', '}')
    return str(json_str)


# Convert a python string to json format
def jsonify_str(source):
    json_str = str(source).replace('\'', '\"')
    return str(json_str)


# Removes duplicated waypoints
def convert_to_unique_list(ls):
    start = ls[0]
    end = ls[len(ls) - 1]
    ls.pop(0)
    ls.pop()
    waypoints = list(OrderedDict.fromkeys(ls))
    waypoints.insert(0, start)
    waypoints.append(end)
    return waypoints


# Creates a dictionary with each market price in item arrays, used in optimization module
def convert_to_markets_for_items_list(itemid_list, midpoint, dist):
    product_list = OrderedDict()  # Dictionary for products
    for itemid in itemid_list:
        shoppinglist_item = models.ShoppingListItem.objects.get(id=itemid)
        base_product = models.BaseProduct.objects.get(productID=shoppinglist_item.product_id)
        product_list[
            itemid] = OrderedDict()  # Uber Super Duper Fix For Wrong Retailer Names in Web-App, don't use plain dict
        retailer_list = get_retailers_in_dist(midpoint, dist)
        for retailer in retailer_list:
            try:
                retailer_product = models.RetailerProduct.objects.get(baseProduct=base_product, retailer=retailer)
                product_list[itemid][retailer.retailerID] = retailer_product.unitPrice
            except ObjectDoesNotExist:  # If item with this market does not exist, give a high price to product for this market
                product_list[itemid][
                    retailer.retailerID] = 99999999  # TODO Find more clever way to exclude out-of-stock retailers
                pass
    # Returns: { <BaseProductID_i>: {<RetailerID_j>: <RetailerProductPrice_ij>, ...}, ...} |||| j is index of market, i is index of product
    return product_list, len(retailer_list)


# Return information of each shopping list of user as json data
def return_shopping_list_info(user):
    shoppinglist_info = {}
    for list in models.UserShoppingList.objects.filter(user=user):
        shoppinglist_info[str(list.shoppingList.listName)] = int(list.shoppingList.listID)
    return jsonify_str(shoppinglist_info)


def add_product_to_list(editing_user, product, shopping_list ):
    if models.ShoppingListItem.objects.filter(list=shopping_list, product=product).count() is 0:
        return models.ShoppingListItem.objects.create(list=shopping_list, product=product, addedBy=editing_user, edited_by=editing_user, quantity=1)
    else:
        existing_product = models.ShoppingListItem.objects.get(list=shopping_list, product=product)
        existing_product.quantity = existing_product.quantity + 1
        existing_product.edited_by = editing_user
        existing_product.save()
        return existing_product


# Return includes of given shopping list object as parameter as json data
def return_shopping_list_data(shoppingList):
    shoppinglist_data = {}
    shoppinglist_data['ListID'] = shoppingList.listID
    shoppinglist_data['ListName'] = shoppingList.listName
    shoppinglist_data['ListProducts'] = []
    for product in models.ShoppingListItem.objects.filter(list=shoppingList):
        shoppinglist_data['ListProducts'].append(
            {'name': "%s %s %s%s" % (
                product.product.brand, product.product.type, product.product.amount, product.product.unit),
             'added_by': product.addedBy.userName, 'quantity': product.quantity, 'item_id': product.id})
    return jsonify_dict(shoppinglist_data)


def encode_password(raw_password):
    return pbkdf2_sha256.encrypt(raw_password, rounds=12000, salt_size=32)


def verify_password(raw_password, encoded_password):
    return pbkdf2_sha256.verify(raw_password, encoded_password)


# Depth first traverse starting from given node as parameter, returns a dictionary with whole product tree under the node
def iterate_product_groups(node):
    tree_dict = {}
    children = models.ProductGroup.objects.filter(parent=node)
    for child in children:  # Continue iterating
        tree_dict.update({child.name: iterate_product_groups(child)})
    return tree_dict


# Return all retailers in given distance from longitude latitude parameters
def get_retailers_in_dist(point, dist):
    current_point = geos.fromstr("SRID=4326;POINT(%s %s)" % (point[0], point[1]))
    distance_from_point = {'km': dist}
    shops = models.Retailer.gis.filter(geoLocation__distance_lte=(current_point, measure.D(**distance_from_point)))
    shops = shops.distance(current_point).order_by('distance')
    return shops


# Calculate distance between two points with haversine formula
def calc_dist(lat_a, long_a, lat_b, long_b):
    lat_a = radians(lat_a)
    lat_b = radians(lat_b)
    long_diff = radians(long_a - long_b)
    distance = (sin(lat_a) * sin(lat_b) +
                cos(lat_a) * cos(lat_b) * cos(long_diff))

    if int(distance) <= 1:
        return 0

    resToMile = degrees(acos(distance)) * 69.09
    resToMt = resToMile / 0.62137119223733
    return resToMt
