import json
from django.core.exceptions import ObjectDoesNotExist
from django.http import JsonResponse
from django.shortcuts import render
from django.urls import reverse
from ObjectiveCostOptimizer.differentialEvolution import init_optimization
from gisModule import models, tools
from django.contrib.gis import geos


def cart(request):
    if request.method == "GET":
        return render(request, 'gisModule/cart.html')

    if request.method == "POST":
        if request.POST.get('get_shopping_list_data'):
            active_user = models.User.objects.get(userID=request.session['user_login_session']['userID'])
            active_list = active_user.activeList
            product_name = []
            product_id = []
            product_quantity = []
            product_added_by = []
            product_edited_by = []
            for product in models.ShoppingListItem.objects.filter(list=active_list):
                product_name.append(product.product.__str__())
                product_id.append(product.product.productID)
                product_quantity.append(product.quantity)
                product_added_by.append(product.addedBy.userName)
                product_edited_by.append(product.edited_by.userName)
            return JsonResponse({'product_name': product_name, 'product_id': product_id, 'product_quantity': product_quantity, 'product_added_by': product_added_by, 'product_changed_by': product_edited_by})

        elif request.POST.get('post_inc_dec_quantity'):
            product = models.BaseProduct.objects.get(productID=request.POST.get('product_id'))
            active_user = models.User.objects.get(userID=request.session['user_login_session']['userID'])
            active_list = active_user.activeList
            list_product = models.ShoppingListItem.objects.get(list=active_list, product=product)
            new_quantity = list_product.quantity + int(request.POST.get('change_amount'))
            list_product.quantity = new_quantity
            list_product.edited_by = active_user
            list_product.save()
            return JsonResponse({'new_quantity': new_quantity, 'new_changed_by': active_user.userName})

        elif request.POST.get('post_change_quantity'):
            product = models.BaseProduct.objects.get(productID=request.POST.get('product_id'))
            active_user = models.User.objects.get(userID=request.session['user_login_session']['userID'])
            active_list = active_user.activeList
            list_product = models.ShoppingListItem.objects.get(list=active_list, product=product)
            new_quantity = int(request.POST.get('new_amount'))
            list_product.quantity = new_quantity
            list_product.edited_by = active_user
            list_product.save()
            return JsonResponse({'new_changed_by': active_user.userName})

        elif request.POST.get('post_remove_from_cart'):
            product = models.BaseProduct.objects.get(productID=request.POST.get('product_id'))
            active_user = models.User.objects.get(userID=request.session['user_login_session']['userID'])
            active_list = active_user.activeList
            models.ShoppingListItem.objects.get(list=active_list, product=product).delete()
            return render(request, 'gisModule/cart.html')


def shop(request):
    root_product_groups = models.ProductGroup.objects.filter(parent=None)
    category_name_list = {}
    for root in root_product_groups:
        category_name_list.update({root.name: json.dumps(tools.iterate_product_groups(root))})
    category_id_list = {}
    for category in models.ProductGroup.objects.all():
        category_id_list.update({category.name: str(category.id)})
    session_user = request.session['user_login_session']  # Get login information from current browser session
    user = models.User.objects.get(userID=session_user['userID'])  # Current user object
    user_prefs = user.preferences
    active_shopping_list = user.activeList
    saved_addresses = models.UserSavedAddress.objects.filter(user=user)
    address_names = []
    address_coords = []
    address_ids = []
    for name in saved_addresses.values('name'):
        address_names.append(name['name'])
    for id in saved_addresses.values('id'):
        address_ids.append(id)
    for coord in saved_addresses.values('geoLocation'):
        address_coords.append(coord['geoLocation'].coords)

    # Temp solution for null objects
    if user.activeList is None:
        shopping_lists_info = None
    else:
        shopping_lists_info = tools.return_shopping_list_info(user)

    if active_shopping_list is None:
        active_list_data = None
    else:
        active_list_data = tools.return_shopping_list_data(active_shopping_list)

    if user_prefs.route_start_point is None:
        start_point_name = ""
    else:
        start_point_name = user_prefs.route_start_point.name
    if user_prefs.route_end_point is None:
        end_point_name = ""
    else:
        end_point_name = user_prefs.route_end_point.name

    # Standard GET request for view
    if request.method == "GET":
        return render(request, 'gisModule/shop.html', {'category_name_list': tools.jsonify_dict(category_name_list),
                                                       'category_id_list': tools.jsonify_dict(category_id_list),
                                                       'user_info': tools.jsonify_str(
                                                           request.session['user_login_session']),
                                                       'shopping_lists_info': shopping_lists_info,
                                                       'active_list_data': active_list_data,
                                                       'search_radius': user_prefs.search_radius,
                                                       'time_cost': user_prefs.time_factor,
                                                       'money_cost': user_prefs.money_factor,
                                                       'dist_cost': user_prefs.dist_factor,
                                                       'address_names': address_names,
                                                       'address_coords': address_coords,
                                                       'address_ids': address_ids,
                                                       'start_point_name': start_point_name,
                                                       'end_point_name': end_point_name})
    # Handle AJAX Post Requests
    if request.method == "POST":
        if request.POST.get("post_load_products"):
            category_id = request.POST.get("category_id")
            group = models.ProductGroup.objects.get(id=category_id)
            products = {}
            for product in models.BaseProduct.objects.filter(group=group):
                products.update({product.__str__(): product.productID})
            return JsonResponse({'loaded_products': products})
        if request.POST.get('post_add_to_cart'):
            product = models.BaseProduct.objects.get(productID=request.POST.get('product_id'))
            editing_user = models.User.objects.get(userID=request.session['user_login_session']['userID'])
            shopping_list = editing_user.activeList
            tools.add_product_to_list(editing_user, product, shopping_list)
            return render(request, 'gisModule/shop.html')


def shopping(request):
    root_product_groups = models.ProductGroup.objects.filter(parent=None)
    product_list = {}
    for root in root_product_groups:
        product_list.update({root.name: json.dumps(tools.iterate_product_groups(root))})
    session_user = request.session['user_login_session']  # Get login information from current browser session
    user = models.User.objects.get(userID=session_user['userID'])  # Current user object
    user_prefs = user.preferences
    active_shopping_list = user.activeList
    saved_addresses = models.UserSavedAddress.objects.filter(user=user)
    address_names = []
    address_coords = []
    address_ids = []
    for name in saved_addresses.values('name'):
        address_names.append(name['name'])
    for id in saved_addresses.values('id'):
        address_ids.append(id)
    for coord in saved_addresses.values('geoLocation'):
        address_coords.append(coord['geoLocation'].coords)

    # Standard GET request for view
    if request.method == "GET":
        return render(request, 'gisModule/shopping.html', {'productTree_data': tools.jsonify_dict(product_list),
                                                           'user_info': tools.jsonify_str(
                                                               request.session['user_login_session']),
                                                           'shopping_lists_info': tools.return_shopping_list_info(user),
                                                           'shopping_list_data': tools.return_shopping_list_data(
                                                               active_shopping_list),
                                                           'active_shopping_cart': active_shopping_list.listName,
                                                           'search_radius': user_prefs.search_radius,
                                                           'time_cost': user_prefs.time_factor,
                                                           'money_cost': user_prefs.money_factor,
                                                           'dist_cost': user_prefs.dist_factor,
                                                           'address_names': address_names,
                                                           'address_coords': address_coords,
                                                           'address_ids': address_ids,
                                                           'start_point_name': user_prefs.route_start_point.name,
                                                           'end_point_name': user_prefs.route_end_point.name})

    # Handle AJAX Post Requests
    if request.method == "POST":
        # Active cart is changed for user
        if request.POST.get("post_active_cart_change"):
            new_list_id = request.POST.get("cartID")
            new_user_shopping_list = models.UserShoppingList.objects.get(user=user,
                                                                         shoppingList=models.ShoppingList.objects.get(
                                                                             listID=new_list_id))
            new_shopping_list = new_user_shopping_list.shoppingList
            user.activeList = new_shopping_list
            user.save()

            return JsonResponse({'shopping_list_name': new_shopping_list.listName,
                                 'shopping_list_data': tools.return_shopping_list_data(new_shopping_list)})

        # An item from cart is removed
        elif request.POST.get("post_item_remove"):
            item_id_to_be_removed = int(request.POST.get("item_id"))
            models.ShoppingListItem.objects.get(id=item_id_to_be_removed).delete()
            return render(request, 'gisModule/shopping.html')

        # A new item is added to active cart
        elif request.POST.get("post_item_add"):
            base_product_id = request.POST.get("id")
            new_quantity = request.POST.get("quantity")
            base_product = models.BaseProduct.objects.get(productID=base_product_id)
            active_list = user.activeList

            try:
                list_item = models.ShoppingListItem.objects.get(product=base_product, list=active_list)
            except models.ShoppingListItem.DoesNotExist:
                list_item = None

            if list_item:
                list_item.quantity = new_quantity
                list_item.save()
                return JsonResponse({'new_id': list_item.id})

            else:
                new_item = models.ShoppingListItem.objects.create(list=active_list, product=base_product, addedBy=user,
                                                                  quantity=new_quantity)
            return JsonResponse({'new_id': new_item.id})

        # An existing item is updated in active cart
        elif request.POST.get("post_item_update"):
            new_quantity = request.POST.get("quantity")
            new_edited_by = request.POST.get("updated_by")
            list_item = models.ShoppingListItem.objects.get(id=int(request.POST.get("id")))
            list_item.quantity = new_quantity
            list_item.addedBy = models.User.objects.get(userName=new_edited_by)
            list_item.save()
            return render(request, 'gisModule/shopping.html')

        # Route calculation request
        elif request.POST.get("checkout"):
            frm = user_prefs.route_start_point
            to = user_prefs.route_end_point
            json_dump = json.dumps(dict(request.POST), ensure_ascii=False)
            json_obj = json.loads(json_dump)
            itemid_list = json_obj['item_id[]']

            start_end_dist = tools.calc_dist(frm.geoLocation.coords[0], frm.geoLocation.coords[1],
                                             to.geoLocation.coords[0],
                                             to.geoLocation.coords[1])  # The distance between start end end points
            start_end_midpoint = geos.LineString(frm.geoLocation,
                                                 to.geoLocation).centroid  # Midpoint between start end end points
            search_radius_w_tolerance = (
                                        start_end_dist + user_prefs.search_radius) / 2.0  # Retailer search circle radius with user defined tolerance
            item_quantity_list = list(map(int, json_obj['item_quantity[]']))

            converted_list, retailer_count = tools.convert_to_markets_for_items_list(itemid_list, start_end_midpoint,
                                                                                     search_radius_w_tolerance)
            route_dicts, pros_cons, champ_indexes, fitness_vectors = init_optimization(
                converted_list, item_quantity_list,
                len(itemid_list),
                retailer_count, frm.geoLocation, to.geoLocation,
                [user_prefs.money_factor, user_prefs.dist_factor, user_prefs.time_factor])

            all_retailers_to_visit = []
            all_products_to_buy = []
            all_route_coords = []
            all_stopover_names = []
            all_prices = []
            all_counts = []

            for i in range(0, len(route_dicts)):
                route_coords = []  # Create a route coord list from response
                stopover_names = []  # Create a route name list from response

                route_coords.append(frm.geoLocation.coords)
                stopover_names.append(frm.name)
                for retailer in list(route_dicts[i].values()):
                    route_coords.append(retailer.geoLocation.coords)
                    stopover_names.append(retailer.retailerName)
                route_coords.append(to.geoLocation.coords)
                stopover_names.append(to.name)

                retailers_to_visit = []
                products_to_buy = []
                prices = []
                counts = []
                for retailer in list(route_dicts[i].values()):
                    retailers_to_visit.append(retailer.retailerName)
                j = 0
                for product in list(route_dicts[i].keys()):
                    products_to_buy.append(product.__str__())
                    prices.append(models.RetailerProduct.objects.get(retailer=list(route_dicts[i].values())[j],
                                                                     baseProduct=product).unitPrice)
                    counts.append(
                        models.ShoppingListItem.objects.get(list=active_shopping_list, product=product).quantity)
                    j += 1

                all_retailers_to_visit.append(retailers_to_visit)
                all_products_to_buy.append(products_to_buy)
                all_route_coords.append(tools.convert_to_unique_list(route_coords))
                all_stopover_names.append(tools.convert_to_unique_list(stopover_names))
                all_prices.append(prices)
                all_counts.append(counts)

            return JsonResponse({'products_to_buy': all_products_to_buy, 'retailers_to_visit': all_retailers_to_visit,
                                 'stopover_names': all_stopover_names,
                                 'route_coords': all_route_coords, 'champ_indexes': champ_indexes,
                                 'pros_cons': pros_cons, 'prices': all_prices, 'counts': all_counts,
                                 'costs': fitness_vectors})

        # User Preference Save Request
        elif request.POST.get("save_preferences"):
            user = models.User.objects.get(userID=request.session['user_login_session']['userID'])
            user_prefs = user.preferences
            user_prefs.money_factor = False
            user_prefs.dist_factor = False
            user_prefs.time_factor = False

            if request.POST.get("money_factor"):
                user_prefs.money_factor = True
            if request.POST.get("dist_factor"):
                user_prefs.dist_factor = True
            if request.POST.get("time_factor"):
                user_prefs.time_factor = True
            if request.POST.get("search_radius"):
                user_prefs.search_radius = int(request.POST.get("search_radius"))
            if request.POST.get("start_id"):
                user_prefs.route_start_point_id = int(request.POST.get("start_id"))
            if request.POST.get("end_id"):
                user_prefs.route_end_point_id = int(request.POST.get("end_id"))

            user_prefs.save()

            return render(request, 'gisModule/shopping.html')

        # Unknown POST request, ignore
        else:
            print("UNKNOWN POST REQUEST:")
            print(request.POST)
            return render(request, 'gisModule/shopping.html')


# View for login page
def login(request):
    if request.method == "GET":
        return render(request, 'gisModule/login.html')

    if request.method == 'POST':
        if request.POST.get('login'):
            username = request.POST.get("username")
            try:
                user = models.User.objects.get(userName=username)
            except ObjectDoesNotExist:
                return tools.bad_request('Wrong password or username')

            if tools.verify_password(request.POST.get('password'), user.password):
                print("signed in: " + user.userName)
                user_login_session = {'userID': user.userID, 'username': username, 'firstname': user.firstName,
                                      'lastName': user.lastName}
                request.session['user_login_session'] = user_login_session
                return JsonResponse({'url': reverse('gisModule:shop')})
            else:
                return tools.bad_request('Wrong password or username')
        elif request.POST.get('register'):
            username = request.POST.get("username")
            if models.User.objects.filter(userName=username).count() is 0:
                email = request.POST.get("email")
                first_name = request.POST.get("first_name")
                last_name = request.POST.get("last_name")
                if models.User.objects.filter(email=email).count() is 0:
                    new_prefs = models.UserPreferences.objects.create(money_factor=True, dist_factor=True, time_factor=True, search_radius=100, route_start_point=None, route_end_point=None)
                    new_usr = models.User.objects.create(userName=username, password=tools.encode_password(request.POST.get("password")), email=email, firstName=first_name, lastName=last_name, preferences=new_prefs, activeList=None)
                    new_usr.preferences.owner = new_usr
                    new_usr.preferences.save()
                    # Login with new account
                    user_login_session = {'userID': new_usr.userID, 'username': username, 'firstname': new_usr.firstName,
                                          'lastName': new_usr.lastName}
                    request.session['user_login_session'] = user_login_session
                    return JsonResponse({'url': reverse('gisModule:shop')})
                else:
                    return tools.bad_request('An account with this email already exist')
            else:
                return tools.bad_request('An account with this username already exist')