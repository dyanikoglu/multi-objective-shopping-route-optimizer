from gisModule import models
from BlameModule import Tools


def new(retailer_product, user, pusher_client):
    if Tools.duplicate_blame(retailer_product, user):
        return False, "You have already blamed this product"
    if not Tools.check_reputation(user):
        return False, "You don't have enough reputation for blaming a product"

    retailer_product.blame_point += Tools.calculate_points(user, retailer_product.retailer)
    retailer_product.save()

    Tools.check_product_blame_level(retailer_product, pusher_client)

    models.Blame.objects.create(retailer_product=retailer_product, user=user, status_code=0)
    return True, "Blame successfully created"


def accept():
    return


def reject():
    return


def review():
    return
