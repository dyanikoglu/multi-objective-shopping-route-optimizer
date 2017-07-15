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
admin.site.register(ShoppingListMember)
admin.site.register(ShoppingList)
admin.site.register(ShoppingListItem)
admin.site.register(UserSavedAddress)
admin.site.register(UserPreferences)
admin.site.register(Friend)
admin.site.register(Group)
admin.site.register(GroupMember)
admin.site.register(Role)
admin.site.register(Blame)
admin.site.register(ProposalSent)
admin.site.register(FalsePriceProposal)
