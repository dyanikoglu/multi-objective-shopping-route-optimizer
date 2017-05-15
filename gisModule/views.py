import json
from django.core.exceptions import ObjectDoesNotExist
from django.http import JsonResponse
from django.shortcuts import render
from django.urls import reverse
from ObjectiveCostOptimizer.differentialEvolution import init_optimization
from gisModule import models, tools
from django.contrib.gis import geos
import pusher

pusher_client = pusher.Pusher(
    app_id='337846',
    key='ea171f7b30a44f1ebf65',
    secret='fb0b3fed734f0fb38f75',
    cluster='eu',
    ssl=True
)


def account(request):
    if request.method == "GET":
        return render(request, 'gisModule/account.html',
                      {'title': 'Account', 'user_info': tools.jsonify_str(request.session['user_login_session'])})

    if request.method == "POST":
        if request.POST.get('send_friend_request'):
            try:
                # TODO For speeding up search process, hash user names into unique numbers and run query on these numbers
                request_user = models.User.objects.get(username=request.POST.get('username'))
            except ObjectDoesNotExist:
                return tools.bad_request('User not found')
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            # TODO Check if these users are already friends / or there is a request pending
            models.Friend.objects.create(user_sender=active_user, user_receiver=request_user)

            # Notify receiver user
            notification = "<b>%s</b> has sent you a friend request" % active_user.username
            pusher_client.trigger('user_%s' % request_user.id, 'friend_request_received', {'message': notification})

            message = "Friend request successfully sent to <b>%s</b>" % request_user.username
            return JsonResponse({'status': 'success', 'message': message})

        elif request.POST.get('fetch_pending_friend_requests'):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            pending_requests = []
            for request in models.Friend.objects.filter(user_sender=active_user, status=False):
                pending_requests.append({'request_id': request.id, 'username': request.user_receiver.username,
                                         'name': "%s %s" % (
                                             request.user_receiver.first_name, request.user_receiver.last_name),
                                         'date': request.date, })
            return JsonResponse({'pending_requests': pending_requests})

        elif request.POST.get('fetch_received_friend_requests'):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            received_requests = []
            for request in models.Friend.objects.filter(user_receiver=active_user, status=False):
                received_requests.append({'request_id': request.id, 'username': request.user_sender.username,
                                          'name': "%s %s" % (
                                              request.user_sender.first_name, request.user_sender.last_name),
                                          'date': request.date, })
            return JsonResponse({'received_requests': received_requests})

        elif request.POST.get('fetch_friend_list'):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            friends = []
            for friend in models.Friend.objects.filter(user_receiver=active_user, status=True):
                friends.append({'request_id': friend.id, 'username': friend.user_sender.username,
                                'name': "%s %s" % (
                                    friend.user_sender.first_name, friend.user_sender.last_name),
                                'date': friend.date, })
            for friend in models.Friend.objects.filter(user_sender=active_user, status=True):
                friends.append({'request_id': friend.id, 'username': friend.user_receiver.username,
                                'name': "%s %s" % (
                                    friend.user_receiver.first_name, friend.user_receiver.last_name),
                                'date': friend.date, })
            return JsonResponse({'friends': friends})

        elif request.POST.get('deny_friend_request'):
            notify_id = models.Friend.objects.get(id=request.POST.get('request_id')).user_sender.id
            try:
                models.Friend.objects.get(id=request.POST.get('request_id')).delete()
            except ObjectDoesNotExist:
                return tools.bad_request('Friend request not found')
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])

            # Notify denied user
            notification = "<b>%s</b> has declined your friend request" % active_user.username
            pusher_client.trigger('user_%s' % notify_id, 'friend_request_denied', {'message': notification})

            message = "Friend request is successfully denied"
            return JsonResponse({'status': 'success', 'message': message})

        elif request.POST.get('cancel_friend_request'):
            notify_id = models.Friend.objects.get(id=request.POST.get('request_id')).user_receiver.id
            try:
                models.Friend.objects.get(id=request.POST.get('request_id')).delete()
            except ObjectDoesNotExist:
                return tools.bad_request('Friend request not found')

            # No notification to show user
            pusher_client.trigger('user_%s' % notify_id, 'friend_request_cancelled', {})

            message = "Pending friend request is successfully cancelled"
            return JsonResponse({'status': 'success', 'message': message})

        elif request.POST.get('remove_friend'):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            try:
                receiver_user = models.Friend.objects.get(id=request.POST.get('request_id')).user_receiver
                sender_user = models.Friend.objects.get(id=request.POST.get('request_id')).user_sender
                if active_user.id == receiver_user.id:
                    notify_id = sender_user.id
                else:
                    notify_id = receiver_user.id
                models.Friend.objects.get(id=request.POST.get('request_id')).delete()
            except ObjectDoesNotExist:
                return tools.bad_request('Relation not found')

            # Notify sender user
            notification = "<b>%s</b> has removed you from the friend list" % active_user.username
            pusher_client.trigger('user_%s' % notify_id, 'removed_from_friendlist', {'message': notification})

            message = "<b>%s</b> successfully removed from your friend list" % receiver_user.username
            return JsonResponse({'status': 'success', 'message': message})

        elif request.POST.get('accept_friend_request'):
            try:
                friend_request = models.Friend.objects.get(id=request.POST.get('request_id'), status=False)
            except ObjectDoesNotExist:
                return tools.bad_request('Friend request not found')

            notify_id = friend_request.user_sender.id
            friend_request.status = True
            friend_request.save()

            # Notify sender user
            notification = "<b>%s</b> has accepted your friend request" % friend_request.user_receiver.username
            pusher_client.trigger('user_%s' % notify_id, 'friend_request_accepted',
                                  {'message': notification})

            message = "Friend request successfully accepted"
            return JsonResponse({'status': 'success', 'message': message})

        elif request.POST.get('create_new_group'):
            new_group = models.Group.objects.create(name=request.POST.get('group_name'))
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            role = models.Role.objects.get(name="Admin")  # TODO Change role implementation later
            models.GroupMember.objects.create(group=new_group, member=active_user, role=role)

            message = "Group successfully created"
            return JsonResponse({'status': 'success', 'message': message})

        elif request.POST.get('fetch_group_list'):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            groups = []
            for group_membership in models.GroupMember.objects.filter(member=active_user):
                group = group_membership.group
                active_role = group_membership.role.name  # TODO Expand Role model with permissions
                members = []

                for other_member in models.GroupMember.objects.filter(group=group):
                    other_user = other_member.member
                    members.append({'user_id': other_user.id, 'username': other_user.username, 'name': "%s %s" % (
                        other_user.first_name, other_user.last_name), 'join_date': other_member.date})
                groups.append(
                    {'group_id': group.id, 'active_role': active_role, 'members': members, 'group_name': group.name,
                     'creation_date': group.date, })

            friends = []
            for friend in models.Friend.objects.filter(user_receiver=active_user, status=True):
                friends.append({'user_id': friend.user_sender.id, 'username': friend.user_sender.username,
                                'name': "%s %s" % (
                                    friend.user_sender.first_name, friend.user_sender.last_name)})
            for friend in models.Friend.objects.filter(user_sender=active_user, status=True):
                friends.append({'user_id': friend.user_receiver.id, 'username': friend.user_receiver.username,
                                'name': "%s %s" % (
                                    friend.user_receiver.first_name, friend.user_receiver.last_name)})

            return JsonResponse({'groups': groups, 'friends': friends})

        elif request.POST.get('quit_from_group'):
            user_to_quit = models.User.objects.get(id=request.POST.get('user_id'))
            group_to_quit = models.Group.objects.get(id=request.POST.get('group_id'))
            models.GroupMember.objects.get(member=user_to_quit, group=group_to_quit).delete()

            # Notify whole group
            for member in models.GroupMember.objects.filter(group=group_to_quit):
                if member.member.id != user_to_quit.id:
                    notification = "<b>%s</b> has quit from <b>%s</b>" % (user_to_quit.username, group_to_quit.name)
                    pusher_client.trigger('user_%s' % member.member.id, 'member_quit_from_group',
                                          {'message': notification})
            tools.is_group_empty(group_to_quit)  # TODO Store member count in group model, remove group if count is zero

            message = "Successfully quit from the group"
            return JsonResponse({'status': 'success', 'message': message})

        elif request.POST.get('remove_from_group'):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            user_to_remove = models.User.objects.get(id=request.POST.get('user_id'))
            group = models.Group.objects.get(id=request.POST.get('group_id'))

            # Notify whole group
            for member in models.GroupMember.objects.filter(group=group):
                if member.member.id == user_to_remove.id:
                    notification = "You are removed from <b>%s</b> by <b>%s</b>" % (group.name, active_user.username)
                else:
                    notification = "<b>%s</b> is removed from <b>%s</b> by <b>%s</b>" % (
                        user_to_remove.username, group.name, active_user.username)
                if member.member.id != active_user.id:
                    pusher_client.trigger('user_%s' % member.member.id, 'member_removed_from_group',
                                          {'message': notification})
            models.GroupMember.objects.get(member=user_to_remove, group=group).delete()
            tools.is_group_empty(group)

            message = "User successfully removed from the group"
            return JsonResponse({'status': 'success', 'message': message})

        elif request.POST.get('add_to_group'):
            try:
                user_to_add = models.User.objects.get(id=request.POST.get('user_id'))  # TODO Username hashing
            except ObjectDoesNotExist:
                return tools.bad_request('User not found')

            try:
                group_to_add = models.Group.objects.get(id=request.POST.get('group_id'))
            except ObjectDoesNotExist:
                return tools.bad_request('Group not found, maybe it\'s removed?')

            try:
                models.GroupMember.objects.get(group=group_to_add, member=user_to_add)
                return tools.bad_request('This user is already in this group')
            except ObjectDoesNotExist:  # Safe to add user to group, no duplicates
                role = models.Role.objects.get(name="Member")  # TODO Change role implementation later
                models.GroupMember.objects.create(group=group_to_add, member=user_to_add, role=role)

            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            # Notify whole group
            for member in models.GroupMember.objects.filter(group=group_to_add):
                if member.member.id != active_user.id:
                    if member.member.id == user_to_add.id:
                        notification = "You are added to group <b>%s</b> by <b>%s</b>" % (
                            group_to_add.name, active_user.username)
                    else:
                        notification = "<b>%s</b> is added to <b>%s</b> by <b>%s</b>" % (
                            user_to_add.username, group_to_add.name, active_user.username)
                    pusher_client.trigger('user_%s' % member.member.id, 'member_added_to_group',
                                          {'message': notification})

            message = "User successfully added to the group"
            return JsonResponse({'status': 'success', 'message': message})

        elif request.POST.get('create_new_list'):
            new_list = models.ShoppingList.objects.create(name=request.POST.get('list_name'))
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            role = models.Role.objects.get(name="Admin")  # TODO Change role implementation later
            models.ShoppingListMember.objects.create(list=new_list, user=active_user, role=role)

            message = "New shopping list successfully created"
            return JsonResponse({'status': 'success', 'message': message})

        elif request.POST.get('fetch_shopping_lists'):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            lists = []
            for list_membership in models.ShoppingListMember.objects.filter(user=active_user):
                list = list_membership.list
                active_role = list_membership.role.name  # TODO Expand Role model with permissions
                members = []

                for other_member in models.ShoppingListMember.objects.filter(list=list):
                    other_user = other_member.user
                    members.append({'user_id': other_user.id, 'username': other_user.username, 'name': "%s %s" % (
                        other_user.first_name, other_user.last_name)})

                lists.append(
                    {'list_id': list.id, 'active_role': active_role, 'members': members, 'list_name': list.name,
                     'creation_date': list.created_at, })

            friends = []
            for friend in models.Friend.objects.filter(user_receiver=active_user, status=True):
                friends.append({'user_id': friend.user_sender.id, 'username': friend.user_sender.username,
                                'name': "%s %s" % (
                                    friend.user_sender.first_name, friend.user_sender.last_name)})
            for friend in models.Friend.objects.filter(user_sender=active_user, status=True):
                friends.append({'user_id': friend.user_receiver.id, 'username': friend.user_receiver.username,
                                'name': "%s %s" % (
                                    friend.user_receiver.first_name, friend.user_receiver.last_name)})

            return JsonResponse({'lists': lists, 'friends': friends})

        elif request.POST.get('quit_from_list'):
            user_to_quit = models.User.objects.get(id=request.POST.get('user_id'))
            try:
                list_to_quit = models.ShoppingList.objects.get(id=request.POST.get('list_id'))
            except ObjectDoesNotExist:
                return tools.bad_request("Shopping list does not exist anymore")

            try:
                models.ShoppingListMember.objects.get(user=user_to_quit, list=list_to_quit).delete()
            except ObjectDoesNotExist:
                return tools.bad_request("You're no longer in this shopping list")

            # Notify whole list
            for member in models.ShoppingListMember.objects.filter(list=list_to_quit):
                if member.user.id != user_to_quit.id:
                    notification = "<b>%s</b> has quit from <b>%s</b>" % (user_to_quit.username, list_to_quit.name)
                    pusher_client.trigger('user_%s' % member.user.id, 'member_quit_from_list',
                                          {'message': notification})
            tools.is_list_empty(list_to_quit)

            message = "Successfully quit from the shopping list"
            return JsonResponse({'status': 'success', 'message': message})

        elif request.POST.get('remove_from_list'):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])

            try:
                list = models.ShoppingList.objects.get(id=request.POST.get('list_id'))
            except ObjectDoesNotExist:
                return tools.bad_request('Shopping list does not exist anymore')

            user_to_remove = models.User.objects.get(id=request.POST.get('user_id'))

            # Notify whole list
            for member in models.ShoppingListMember.objects.filter(list=list):
                if member.user.id == user_to_remove.id:
                    notification = "You are removed from <b>%s</b> by <b>%s</b>" % (list.name, active_user.username)
                else:
                    notification = "<b>%s</b> is removed from <b>%s</b> by <b>%s</b>" % (
                        user_to_remove.username, list.name, active_user.username)
                if member.user.id != active_user.id:
                    pusher_client.trigger('user_%s' % member.user.id, 'member_removed_from_list',
                                          {'message': notification})

            try:
                models.ShoppingListMember.objects.get(user=user_to_remove, list=list).delete()
            except ObjectDoesNotExist:
                return tools.bad_request("This user is no longer in this group")
            tools.is_list_empty(list)

            message = "Shopping list is successfully unshared with the user"
            return JsonResponse({'status': 'success', 'message': message})

        elif request.POST.get('add_to_list'):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            user_to_add = models.User.objects.get(id=request.POST.get('user_id'))  # TODO Username hashing

            try:
                list_to_add = models.ShoppingList.objects.get(id=request.POST.get('list_id'))
            except ObjectDoesNotExist:
                return tools.bad_request('Shopping list does not exist anymore')

            role = models.Role.objects.get(name="Member")  # TODO Change role implementation later

            try:
                models.ShoppingListMember.objects.get(list=list_to_add, user=user_to_add)
                return tools.bad_request('This user is already in this list')
            except ObjectDoesNotExist:  # Safe to add user to list, no duplicates
                models.ShoppingListMember.objects.create(list=list_to_add, user=user_to_add, role=role)

            # Notify whole group
            for member in models.ShoppingListMember.objects.filter(list=list_to_add):
                if member.user.id != active_user.id:
                    if member.user.id == user_to_add.id:
                        notification = "You are added to shopping list <b>%s</b> by <b>%s</b>" % (
                            list_to_add.name, active_user.username)
                    else:
                        notification = "<b>%s</b> is added to shopping list <b>%s</b> by <b>%s</b>" % (
                            user_to_add.username, list_to_add.name, active_user.username)
                    pusher_client.trigger('user_%s' % member.user.id, 'member_added_to_list', {'message': notification})

            message = "Shopping list is successfully shared with user"
            return JsonResponse({'status': 'success', 'message': message})


def cart(request):
    if request.method == "GET":
        return render(request, 'gisModule/cart.html',
                      {'title': 'Cart', 'user_info': tools.jsonify_str(request.session['user_login_session'])})

    if request.method == "POST":
        if request.POST.get('get_shopping_list_data'):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            active_list = active_user.active_list
            product_name = []
            product_id = []
            product_quantity = []
            product_added_by = []
            product_edited_by = []
            for product in models.ShoppingListItem.objects.filter(list=active_list):
                product_name.append(product.product.name)
                product_id.append(product.product.productID)
                product_quantity.append(product.quantity)
                product_added_by.append(product.addedBy.username)
                product_edited_by.append(product.edited_by.username)
            return JsonResponse(
                {'product_name': product_name, 'product_id': product_id, 'product_quantity': product_quantity,
                 'product_added_by': product_added_by, 'product_changed_by': product_edited_by})

        elif request.POST.get('post_inc_dec_quantity'):
            product = models.BaseProduct.objects.get(productID=request.POST.get('product_id'))
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            active_list = active_user.active_list
            try:
                list_product = models.ShoppingListItem.objects.get(list=active_list, product=product)
            except ObjectDoesNotExist:
                return tools.bad_request("This product does not exist in the shopping list anymore")
            new_quantity = list_product.quantity + int(request.POST.get('change_amount'))
            list_product.quantity = new_quantity
            list_product.edited_by = active_user
            list_product.save()

            # Notify other users sharing the cart
            for user_shopping_list in models.ShoppingListMember.objects.filter(list=active_list):
                notify_id = user_shopping_list.user.id
                if notify_id != active_user.id:  # Except current user
                    notification = "<b>%s</b> has changed the quantity of <b>%s</b> as <b>%s</b>" % (
                        active_user.username, product.name, new_quantity)
                    pusher_client.trigger('user_%s' % notify_id, 'product_quantity_change',
                                          {'message': notification, 'product_id': request.POST.get('product_id'),
                                           'new_quantity': new_quantity, 'new_changed_by': active_user.username})

            message = "Successfully changed the quantity of <b>%s</b>" % product.name
            return JsonResponse(
                {'message': message, 'new_quantity': new_quantity, 'new_changed_by': active_user.username})

        elif request.POST.get('post_change_quantity'):
            product = models.BaseProduct.objects.get(productID=request.POST.get('product_id'))
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            active_list = active_user.active_list

            try:
                list_product = models.ShoppingListItem.objects.get(list=active_list, product=product)
            except ObjectDoesNotExist:
                return tools.bad_request("This product does not exist in the shopping list anymore")

            new_quantity = int(request.POST.get('new_amount'))
            list_product.quantity = new_quantity
            list_product.edited_by = active_user
            list_product.save()

            # Notify other users sharing the cart
            for user_shopping_list in models.ShoppingListMember.objects.filter(list=active_list):
                notify_id = user_shopping_list.user.id
                if notify_id != active_user.id:  # Except current user
                    notification = "<b>%s</b> has changed the quantity of <b>%s</b> as <b>%s</b>" % (
                        active_user.username, product.name, new_quantity)
                    pusher_client.trigger('user_%s' % notify_id, 'product_quantity_change',
                                          {'message': notification, 'product_id': request.POST.get('product_id'),
                                           'new_quantity': new_quantity, 'new_changed_by': active_user.username})

            message = "Successfully changed the quantity of <b>%s</b>" % product.name
            return JsonResponse({'message': message, 'new_changed_by': active_user.username})

        elif request.POST.get('post_remove_from_cart'):
            product = models.BaseProduct.objects.get(productID=request.POST.get('product_id'))
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            active_list = active_user.active_list

            try:
                models.ShoppingListItem.objects.get(list=active_list, product=product).delete()
            except ObjectDoesNotExist:
                return tools.bad_request("This product does not exist in the shopping list anymore")

            # Notify other users sharing the cart
            for user_shopping_list in models.ShoppingListMember.objects.filter(list=active_list):
                notify_id = user_shopping_list.user.id
                if notify_id != active_user.id:  # Except current user
                    notification = "<b>%s</b> has removed <b>%s</b> from the shopping list" % (
                        active_user.username, product.name)
                    pusher_client.trigger('user_%s' % notify_id, 'product_remove',
                                          {'message': notification,
                                           'product_changed_by': active_user.username,
                                           'product_id': request.POST.get('product_id')})

                message = "Successfully removed the <b>%s</b> from shopping list" % product.name
                return JsonResponse({'status': 'success', 'message': message})


def shop(request):
    try:
        session_user = request.session['user_login_session']  # Get login information from current browser session
    except KeyError:
        return render(request, 'gisModule/login.html')
    root_product_groups = models.ProductGroup.objects.filter(parent=None)
    category_name_list = {}
    for root in root_product_groups:
        category_name_list.update({root.name: json.dumps(tools.iterate_product_groups(root))})
    category_id_list = {}
    for category in models.ProductGroup.objects.all():
        category_id_list.update({category.name: str(category.id)})
    user = models.User.objects.get(id=session_user['id'])  # Current user object
    user_prefs = user.preferences
    active_shopping_list = user.active_list
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
    if user.active_list is None:
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
        return render(request, 'gisModule/shop.html',
                      {'title': 'Shop', 'category_name_list': tools.jsonify_dict(category_name_list),
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
                products.update({product.name: product.productID})
            return JsonResponse({'loaded_products': products, 'category_id': category_id})
        elif request.POST.get('post_add_to_cart'):
            product = models.BaseProduct.objects.get(productID=request.POST.get('product_id'))
            editing_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            shopping_list = editing_user.active_list
            list_product = tools.add_product_to_list(editing_user, product, shopping_list)

            # Notify other users sharing the cart
            for user_shopping_list in models.ShoppingListMember.objects.filter(list=shopping_list):
                notify_id = user_shopping_list.user.id
                if user_shopping_list.user.id != editing_user.id:  # Except current user
                    pusher_client.trigger('user_%s' % notify_id, 'product_add',
                                          {'product_name': product.name,
                                           'product_id': request.POST.get('product_id'),
                                           'product_quantity': list_product.quantity,
                                           'product_added_by': list_product.addedBy.username,
                                           'product_changed_by': list_product.edited_by.username})

            return render(request, 'gisModule/shop.html')

        elif request.POST.get('post_search_product'):
            search_text = request.POST.get('search_text').split()
            queryset = models.BaseProduct.objects.all()
            for string in search_text:
                queryset = queryset.filter(name__icontains=string)
            products = {}
            for product in queryset:
                products.update({product.name: product.productID})
            return JsonResponse({'loaded_products': products})


def shopping(request):
    root_product_groups = models.ProductGroup.objects.filter(parent=None)
    product_list = {}
    for root in root_product_groups:
        product_list.update({root.name: json.dumps(tools.iterate_product_groups(root))})
    session_user = request.session['user_login_session']  # Get login information from current browser session
    user = models.User.objects.get(id=session_user['id'])  # Current user object
    user_prefs = user.preferences
    active_shopping_list = user.active_list
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
                                                           'active_shopping_cart': active_shopping_list.name,
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
            new_user_shopping_list = models.ShoppingListMember.objects.get(user=user,
                                                                         list=models.ShoppingList.objects.get(
                                                                             id=new_list_id))
            new_shopping_list = new_user_shopping_list.list
            user.active_list = new_shopping_list
            user.save()

            return JsonResponse({'shopping_list_name': new_shopping_list.name,
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
            active_list = user.active_list

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
            list_item.addedBy = models.User.objects.get(username=new_edited_by)
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
                    products_to_buy.append(product.name)
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
            user = models.User.objects.get(id=request.session['user_login_session']['id'])
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
                user = models.User.objects.get(username=username)
            except ObjectDoesNotExist:
                return tools.bad_request('Wrong password or username')

            if tools.verify_password(request.POST.get('password'), user.password):
                user_login_session = {'status': 'logged_in', 'id': user.id, 'username': username,
                                      'first_name': user.first_name,
                                      'last_name': user.last_name}
                request.session['user_login_session'] = user_login_session
                return JsonResponse({'url': reverse('gisModule:shop')})
            else:
                return tools.bad_request('Wrong password or username')
        elif request.POST.get('register'):
            username = request.POST.get("username")
            if models.User.objects.filter(username=username).count() is 0:
                email = request.POST.get("email")
                first_name = request.POST.get("first_name")
                last_name = request.POST.get("last_name")
                if models.User.objects.filter(email=email).count() is 0:
                    new_prefs = models.UserPreferences.objects.create(money_factor=True, dist_factor=True,
                                                                      time_factor=True, search_radius=100,
                                                                      route_start_point=None, route_end_point=None)
                    new_usr = models.User.objects.create(username=username,
                                                         password=tools.encode_password(request.POST.get("password")),
                                                         email=email, first_name=first_name, last_name=last_name,
                                                         preferences=new_prefs, active_list=None)
                    new_usr.preferences.owner = new_usr
                    new_usr.preferences.save()
                    # Login with this new account
                    user_login_session = {'status': 'logged_in', 'id': new_usr.id, 'username': username,
                                          'first_name': new_usr.first_name,
                                          'last_name': new_usr.last_name}
                    request.session['user_login_session'] = user_login_session
                    return JsonResponse({'url': reverse('gisModule:shop')})
                else:
                    return tools.bad_request('An account with this email already exist')
            else:
                return tools.bad_request('An account with this username already exist')
