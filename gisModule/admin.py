from django.contrib import admin
from .models import *

admin.site.register(Retailer)
admin.site.register(City)
admin.site.register(District)
admin.site.register(RetailerType)
admin.site.register(ProductGroup)
admin.site.register(BaseProduct)
admin.site.register(RetailerProduct)
admin.site.register(User)
admin.site.register(UserShoppingList)
admin.site.register(ShoppingList)
admin.site.register(ShoppingListItem)
admin.site.register(TreeEdge)
admin.site.register(UserSavedAddress)
admin.site.register(UserPreferences)
