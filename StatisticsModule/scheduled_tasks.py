from gisModule import models


def basic_statistics():
    for user in models.User.objects.all():
        statistic = user.statistics

        statistic.blame_count = len(models.Blame.objects.filter(user=user))

        lists_completed = 0
        for list_member in models.ShoppingListMember.objects.filter(user=user):
            if list_member.list.completed:
                lists_completed += 1
        statistic.shoppingListsComplete = lists_completed

        items_bought = 0
        product_freqs = {}
        category_freqs = {}
        retailer_freqs = {}
        for item_bought in models.ShoppingListItem.objects.filter(added_by=user):
            # Skip non-owned by a list products
            if item_bought.list is None:
                continue

            # Skip still not bought products
            if not item_bought.list.completed:
                continue

            if item_bought.product.group.name in category_freqs:
                category_freqs[str(item_bought.product.group.name)] += 1
            else:
                category_freqs[str(item_bought.product.group.name)] = 1

            if item_bought.product.name in product_freqs:
                product_freqs[str(item_bought.product.name)] += 1
            else:
                product_freqs[str(item_bought.product.name)] = 1

            if item_bought.purchased_from.name in retailer_freqs:
                retailer_freqs[str(item_bought.purchased_from.name)] += 1
            else:
                retailer_freqs[str(item_bought.purchased_from.name)] = 1

            items_bought += 1

        max_product_freq = 0
        max_category_freq = 0
        max_retailer_freq = 0
        most_freq_product = None
        most_freq_category = None
        most_freq_retailer = None
        for key in product_freqs.keys():
            if product_freqs[key] > max_product_freq:
                max_product_freq = product_freqs[key]
                most_freq_product = key

        for key in category_freqs.keys():
            if category_freqs[key] > max_category_freq:
                max_category_freq = category_freqs[key]
                most_freq_category = str(key)

        for key in retailer_freqs.keys():
            if retailer_freqs[key] > max_retailer_freq:
                max_retailer_freq = retailer_freqs[key]
                most_freq_retailer = str(key)

        statistic.itemsBought = items_bought
        statistic.favoriteCategory = most_freq_category
        statistic.favoriteProduct = most_freq_product
        statistic.favorite_retailer = most_freq_retailer
        statistic.save()
