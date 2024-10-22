import json
from django.core.exceptions import ObjectDoesNotExist
from django.http import JsonResponse
from django.shortcuts import render
from django.urls import reverse
from ObjectiveCostOptimizer.differentialEvolution import init_optimization
from gisModule import models, tools
from django.contrib.gis import geos
from BlameModule import event_handler as BlameModule
from datetime import datetime
from dateutil.tz import tzlocal
import pusher

pusher_client = pusher.Pusher(
    app_id='337846',
    key='ea171f7b30a44f1ebf65',
    secret='fb0b3fed734f0fb38f75',
    cluster='eu',
    ssl=True
)


def handler404(request):
    return render(request, 'gisModule/404.html', status=404)


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
            pusher_client.trigger('%s' % request_user.id, 'friend_request_received', {'message': notification})
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
            pusher_client.trigger('%s' % notify_id, 'friend_request_denied', {'message': notification})

            message = "Friend request is successfully denied"
            return JsonResponse({'status': 'success', 'message': message})

        elif request.POST.get('cancel_friend_request'):
            notify_id = models.Friend.objects.get(id=request.POST.get('request_id')).user_receiver.id
            try:
                models.Friend.objects.get(id=request.POST.get('request_id')).delete()
            except ObjectDoesNotExist:
                return tools.bad_request('Friend request not found')

            # No notification to show user
            pusher_client.trigger('%s' % notify_id, 'friend_request_cancelled', {})

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
            pusher_client.trigger('%s' % notify_id, 'removed_from_friendlist', {'message': notification})

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
            pusher_client.trigger('%s' % notify_id, 'friend_request_accepted',
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
                    pusher_client.trigger('%s' % member.member.id, 'member_quit_from_group',
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
                    pusher_client.trigger('%s' % member.member.id, 'member_removed_from_group',
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
                    pusher_client.trigger('%s' % member.member.id, 'member_added_to_group',
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
                if not list_membership.list.completed:
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
                membership = models.ShoppingListMember.objects.get(user=user_to_quit, list=list_to_quit)
            except ObjectDoesNotExist:
                return tools.bad_request("You're no longer in this shopping list")
            tools.check_shopping_list_integrity(user_to_quit, membership.list)
            membership.delete()

            # Notify whole list
            for member in models.ShoppingListMember.objects.filter(list=list_to_quit):
                if member.user.id != user_to_quit.id:
                    notification = "<b>%s</b> has quit from <b>%s</b>" % (user_to_quit.username, list_to_quit.name)
                    pusher_client.trigger('%s' % member.user.id, 'member_quit_from_list',
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
                    pusher_client.trigger('%s' % member.user.id, 'member_removed_from_list',
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
                    pusher_client.trigger('%s' % member.user.id, 'member_added_to_list', {'message': notification})

            message = "Shopping list is successfully shared with user"
            return JsonResponse({'status': 'success', 'message': message})

        elif request.POST.get('create_address_entry'):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            try:
                models.UserSavedAddress.objects.create(user=active_user, name=request.POST.get('address_name'),
                                                       address=request.POST.get('address'))
            except ValueError:
                return tools.bad_request('Address is not valid')

            message = "New address entry successfully created"
            return JsonResponse({'status': 'success', 'message': message})

        elif request.POST.get('fetch_addresses'):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            addresses = []
            for address in models.UserSavedAddress.objects.filter(user=active_user):
                addresses.append({'address_name': address.name, 'address': address.address, 'address_id': address.id})
            return JsonResponse({'addresses': addresses})

        elif request.POST.get('remove_address'):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            saved_start_point = active_user.preferences.route_start_point
            saved_end_point = active_user.preferences.route_end_point
            address_id_to_delete = int(request.POST.get('address_id'))

            # Keep integrity of database
            if saved_start_point and saved_start_point.id == address_id_to_delete:
                active_user.preferences.route_start_point = None
                active_user.preferences.save()
            if saved_end_point and saved_end_point.id == address_id_to_delete:
                active_user.preferences.route_end_point = None
                active_user.preferences.save()

            try:
                models.UserSavedAddress.objects.get(id=request.POST.get('address_id')).delete()
            except ObjectDoesNotExist:
                return tools.bad_request('Address is not found, maybe it\'s removed anytime soon?')

            message = "Address entry successfully removed"
            return JsonResponse({'status': 'success', 'message': message})

        elif request.POST.get('fetch_route_default_settings'):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            prefs = active_user.preferences

            addresses = []
            for address in models.UserSavedAddress.objects.filter(user=active_user):
                addresses.append({'address_name': address.name, 'address': address.address, 'address_id': address.id})

            route_start_point = prefs.route_start_point
            route_end_point = prefs.route_end_point

            # If user's start or end address points are null, send ids as -1, this will correspond to "- Select -" option
            # in combobox
            if route_start_point is None:
                route_start_point_id = -1
            else:
                route_start_point_id = route_start_point.id
            if route_end_point is None:
                route_end_point_id = -1
            else:
                route_end_point_id = route_end_point.id

            return JsonResponse(
                {'opt_money': prefs.money_factor, 'opt_dist': prefs.dist_factor, 'opt_time': prefs.time_factor,
                 'tolerance': prefs.search_radius, 'addresses': addresses, 'start_point_id': route_start_point_id,
                 'end_point_id': route_end_point_id})

        elif request.POST.get('save_route_defaults'):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            prefs = active_user.preferences

            prefs.time_factor = bool(request.POST.get('opt_time'))
            prefs.money_factor = bool(request.POST.get('opt_money'))
            prefs.dist_factor = bool(request.POST.get('opt_dist'))
            prefs.search_radius = int(request.POST.get('tolerance'))

            # If index is selected as -1, this means user set his/her address to null in purpose, do not change this address
            if int(request.POST.get('start_point')) != -1:
                prefs.route_start_point = models.UserSavedAddress.objects.get(id=request.POST.get('start_point'))
            if int(request.POST.get('end_point')) != -1:
                prefs.route_end_point = models.UserSavedAddress.objects.get(id=request.POST.get('end_point'))
            prefs.save()

            message = "Default settings are successfully changed"
            return JsonResponse({'status': 'success', 'message': message})

        elif request.POST.get('fetch_pending_proposal'):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])

            try:
                # Find non-replied proposals of this user
                current_proposal = models.ProposalSent.objects.get(user=active_user, response=None)
            except ObjectDoesNotExist:
                return tools.bad_request('No pending proposal exists')

            related_retailer = current_proposal.false_price_proposal.retailer
            related_product = current_proposal.false_price_proposal.retailer_product

            product = related_product.baseProduct
            other_prices = []
            for retailer_product in models.RetailerProduct.objects.all().filter(baseProduct=product):
                if retailer_product.id != related_product.id:
                    other_prices.append(
                        {'retailer_name': retailer_product.retailer.name, 'retailer_price': retailer_product.unitPrice})

            return JsonResponse({'other_prices': other_prices, 'sent_proposal_id': current_proposal.id,
                                 'related_retailer_name': related_retailer.name,
                                 'related_product_price': related_product.unitPrice,
                                 'related_product_name': related_product.baseProduct.name})

        elif request.POST.get('send_reply_to_proposal'):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            current_proposal = models.ProposalSent.objects.get(id=request.POST.get('proposal_id'))
            current_proposal.response = request.POST.get('response') == 'true'
            current_proposal.save()
            current_proposal.false_price_proposal.answer_count += 1
            current_proposal.false_price_proposal.save()

            message = "Reply successfully sent"
            return JsonResponse({'status': 'success', 'message': message})

        elif request.POST.get("fetch_statistics"):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            statistics = active_user.statistics

            return JsonResponse({'total_blames': statistics.blame_count, 'total_products': statistics.itemsBought,
                                 'total_shopping_lists': statistics.shoppingListsComplete,
                                 'favorite_category': statistics.favoriteCategory,
                                 'favorite_product': statistics.favoriteProduct,
                                 'favorite_retailer': statistics.favorite_retailer,
                                 'reputation': statistics.reputation})

        elif request.POST.get("fetch_categorical_statistics"):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])

            category_price = {}
            for purchase in models.ShoppingListItem.objects.filter(purchased_by=active_user, is_purchased=True):
                category = str(purchase.product.group.name)
                price = float(purchase.quantity * purchase.unit_purchase_price)
                if category not in category_price:
                    category_price[category] = price
                else:
                    category_price[category] += price

            categories = []
            prices = []
            for key, value in category_price.items():
                categories.append(key)
                prices.append(value)

            return JsonResponse({'keys': categories, 'values': prices, 'title': 'Total Money Spent Per Category',
                                 'key_name': 'Category', 'value_name': 'Total Money Spent'})

        elif request.POST.get("fetch_retailer_price_stats"):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])

            retailer_price = {}
            for purchase in models.ShoppingListItem.objects.filter(purchased_by=active_user, is_purchased=True):
                retailer = str(purchase.purchased_from.name)
                price = float(purchase.quantity * purchase.unit_purchase_price)
                if retailer not in retailer_price:
                    retailer_price[retailer] = price
                else:
                    retailer_price[retailer] += price

            retailers = []
            prices = []
            for key, value in retailer_price.items():
                retailers.append(key)
                prices.append(value)

            return JsonResponse({'keys': retailers, 'values': prices, 'title': 'Total Money Spent Per Retailer',
                                 'key_name': 'Retailer', 'value_name': 'Total Money Spent'})

        elif request.POST.get("fetch_category_item_count_stats"):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])

            category_count = {}
            for purchase in models.ShoppingListItem.objects.filter(purchased_by=active_user, is_purchased=True):
                category = str(purchase.product.group.name)
                count = purchase.quantity
                if category not in category_count:
                    category_count[category] = count
                else:
                    category_count[category] += count

            categories = []
            counts = []
            for key, value in category_count.items():
                categories.append(key)
                counts.append(value)

            return JsonResponse({'keys': categories, 'values': counts, 'title': 'Purchased Product Count Per Category',
                                 'key_name': 'Category', 'value_name': 'Purchased Product Count'})

        elif request.POST.get("fetch_retailer_item_count_stats"):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])

            retailer_count = {}
            for purchase in models.ShoppingListItem.objects.filter(purchased_by=active_user, is_purchased=True):
                retailer = str(purchase.purchased_from.name)
                count = purchase.quantity
                if retailer not in retailer_count:
                    retailer_count[retailer] = count
                else:
                    retailer_count[retailer] += count

            retailers = []
            counts = []
            for key, value in retailer_count.items():
                retailers.append(key)
                counts.append(value)

            return JsonResponse({'keys': retailers, 'values': counts, 'title': 'Purchased Product Count Per Retailer',
                                 'key_name': 'Retailer', 'value_name': 'Purchased Product Count'})

        elif request.POST.get("fetch_shopping_log"):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])

            table_data = []
            for purchase in models.ShoppingListItem.objects.filter(purchased_by=active_user, is_purchased=True):
                purchase_data = []
                purchase_data.append(purchase.product.name)
                purchase_data.append(purchase.purchased_from.name)
                purchase_data.append(purchase.purchase_date.date().isoformat())
                purchase_data.append(purchase.quantity)
                purchase_data.append(purchase.unit_purchase_price)
                purchase_data.append(purchase.quantity * purchase.unit_purchase_price)
                table_data.append(purchase_data)

            return JsonResponse({'table_data': table_data})

        elif request.POST.get("submit_date_filter"):
            print(request.POST)

            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])

            table_data = []

            for purchase in models.ShoppingListItem.objects.filter(purchased_by=active_user, is_purchased=True,
                                                                   purchase_date__range=[
                                                                       request.POST.get("start_date"),
                                                                       request.POST.get("end_date")]):
                purchase_data = []
                purchase_data.append(purchase.product.name)
                purchase_data.append(purchase.purchased_from.name)
                purchase_data.append(purchase.purchase_date.date().isoformat())
                purchase_data.append(purchase.quantity)
                purchase_data.append(purchase.unit_purchase_price)
                purchase_data.append(purchase.quantity * purchase.unit_purchase_price)
                table_data.append(purchase_data)

            return JsonResponse({'table_data': table_data})


def cart(request):
    if request.method == "GET":
        return render(request, 'gisModule/cart.html',
                      {'title': 'Cart', 'user_info': tools.jsonify_str(request.session['user_login_session'])})

    if request.method == "POST":
        if request.POST.get('get_shopping_list_data'):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            if active_user.active_list is not None:
                if not active_user.active_list.completed:
                    active_list = active_user.active_list
                else:
                    active_list = None
            else:
                active_list = None

            # Keep database integrity clean, if active list is null while opening cart page, assign a existing cart
            # or create an empty cart immediately
            another_list_exists = False
            if active_list is None:
                for shopping_list_membership in models.ShoppingListMember.objects.filter(user=active_user):
                    if not shopping_list_membership.list.completed:
                        active_user.active_list = shopping_list_membership.list
                        active_user.save()
                        another_list_exists = True
                        active_list = shopping_list_membership.list
                        break
                if not another_list_exists:
                    active_list = models.ShoppingList.objects.create(name="My First Shopping List")
                    role = models.Role.objects.get(name='Admin')  # TODO Change role assignments
                    models.ShoppingListMember.objects.create(role=role, user=active_user, list=active_list)
                    active_user.active_list = active_list
                    active_user.save()

            product_name = []
            product_id = []
            product_quantity = []
            product_added_by = []
            product_edited_by = []
            for product in models.ShoppingListItem.objects.filter(list=active_list):
                product_name.append(product.product.name)
                product_id.append(product.product.id)
                product_quantity.append(product.quantity)
                product_added_by.append(product.added_by.username)
                product_edited_by.append(product.edited_by.username)
            return JsonResponse(
                {'active_list_name': active_list.name, 'active_list_id': active_list.id, 'product_name': product_name,
                 'product_id': product_id, 'product_quantity': product_quantity,
                 'product_added_by': product_added_by, 'product_changed_by': product_edited_by})

        elif request.POST.get('post_inc_dec_quantity'):
            product = models.BaseProduct.objects.get(id=request.POST.get('product_id'))
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
                    # Notify if cart is active on others users or their settings allow notifications from other carts
                    if not user_shopping_list.user.preferences.get_notif_only_for_active_list or user_shopping_list.list.id == user_shopping_list.user.active_list.id:
                        notification = "<b>%s</b> has changed the quantity of <b>%s</b> as <b>%s</b> in <b>%s</b>" % (
                            active_user.username, product.name, new_quantity, active_list.name)
                        pusher_client.trigger('%s' % notify_id, 'product_quantity_change',
                                              {'message': notification, 'product_id': request.POST.get('product_id'),
                                               'new_quantity': new_quantity, 'new_changed_by': active_user.username})

            message = "Successfully changed the quantity of <b>%s</b>" % product.name
            return JsonResponse(
                {'message': message, 'new_quantity': new_quantity, 'new_changed_by': active_user.username})

        elif request.POST.get('post_change_quantity'):
            product = models.BaseProduct.objects.get(id=request.POST.get('product_id'))
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
                    # Notify if cart is active on others users or their settings allow notifications from other carts
                    if not user_shopping_list.user.preferences.get_notif_only_for_active_list or user_shopping_list.list.id == user_shopping_list.user.active_list.id:
                        notification = "<b>%s</b> has changed the quantity of <b>%s</b> as <b>%s</b> in <b>%s</b>" % (
                            active_user.username, product.name, new_quantity, active_list.name)
                        pusher_client.trigger('%s' % notify_id, 'product_quantity_change',
                                              {'message': notification, 'product_id': request.POST.get('product_id'),
                                               'new_quantity': new_quantity, 'new_changed_by': active_user.username})

            message = "Successfully changed the quantity of <b>%s</b>" % product.name
            return JsonResponse({'message': message, 'new_changed_by': active_user.username})

        elif request.POST.get('post_remove_from_cart'):
            product = models.BaseProduct.objects.get(id=request.POST.get('product_id'))
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
                    # Notify if cart is active on others users or their settings allow notifications from other carts
                    if not user_shopping_list.user.preferences.get_notif_only_for_active_list or user_shopping_list.list.id == user_shopping_list.user.active_list.id:
                        notification = "<b>%s</b> has removed <b>%s</b> from <b>%s</b>" % (
                            active_user.username, product.name, active_list.name)
                        pusher_client.trigger('%s' % notify_id, 'product_remove',
                                              {'message': notification,
                                               'product_changed_by': active_user.username,
                                               'product_id': request.POST.get('product_id')})

            message = "Successfully removed the <b>%s</b> from shopping list" % product.name
            return JsonResponse({'status': 'success', 'message': message})

        elif request.POST.get('fetch_shopping_lists'):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            lists = []
            for shopping_list_membership in models.ShoppingListMember.objects.filter(user=active_user):
                if not shopping_list_membership.list.completed:
                    lists.append(
                        {'list_name': shopping_list_membership.list.name, 'list_id': shopping_list_membership.list.id})
            return JsonResponse({'lists': lists, 'active_list_id': active_user.active_list.id})

        elif request.POST.get('change_active_list'):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            new_active_list = models.ShoppingList.objects.get(id=request.POST.get('list_id'))
            active_user.active_list = new_active_list
            active_user.save()
            return JsonResponse({'status': 'success'})

        elif request.POST.get('fetch_route_defaults'):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            prefs = active_user.preferences

            addresses = []
            for address in models.UserSavedAddress.objects.filter(user=active_user):
                addresses.append({'address_name': address.name, 'address': address.address, 'address_id': address.id})

            route_start_point = prefs.route_start_point
            route_end_point = prefs.route_end_point

            # If user's start or end address points are null, send ids as -1, this will correspond to "- Select -" option
            # in combobox
            if route_start_point is None:
                route_start_point_id = -1
            else:
                route_start_point_id = route_start_point.id
            if route_end_point is None:
                route_end_point_id = -1
            else:
                route_end_point_id = route_end_point.id

            return JsonResponse(
                {'opt_money': prefs.money_factor, 'opt_dist': prefs.dist_factor, 'opt_time': prefs.time_factor,
                 'tolerance': prefs.search_radius, 'addresses': addresses, 'start_point_id': route_start_point_id,
                 'end_point_id': route_end_point_id})

        elif request.POST.get('save_as_route_defaults'):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            prefs = active_user.preferences

            prefs.time_factor = bool(request.POST.get('opt_time'))
            prefs.money_factor = bool(request.POST.get('opt_money'))
            prefs.dist_factor = bool(request.POST.get('opt_dist'))

            if request.POST.get('tolerance') == '':
                return tools.bad_request('Route radius cannot be blank')

            prefs.search_radius = int(request.POST.get('tolerance'))

            if int(request.POST.get('start_point')) != -1:
                prefs.route_start_point = models.UserSavedAddress.objects.get(id=request.POST.get('start_point'))
            if int(request.POST.get('end_point')) != -1:
                prefs.route_end_point = models.UserSavedAddress.objects.get(id=request.POST.get('end_point'))
            prefs.save()

            message = "Current settings are successfully saved as defaults"
            return JsonResponse({'status': 'success', 'message': message})

        elif request.POST.get('initiate_route_calculation'):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            user_prefs = active_user.preferences
            active_list = active_user.active_list
            frm = user_prefs.route_start_point
            to = user_prefs.route_end_point

            if user_prefs.money_factor is False and user_prefs.dist_factor is False and user_prefs.time_factor is False:
                return tools.bad_request('You should enable at least one optimization')

            if len(models.ShoppingListItem.objects.filter(list=active_list)) == 0:
                return tools.bad_request('Your cart is empty')

            if frm is None:
                return tools.bad_request('Route start point cannot be blank')

            if to is None:
                return tools.bad_request('Route end point cannot be blank')

            start_end_dist = tools.calc_dist(frm.geolocation.coords[0], frm.geolocation.coords[1],
                                             to.geolocation.coords[0],
                                             to.geolocation.coords[1])  # The distance between start end end points

            start_end_midpoint = geos.LineString(frm.geolocation,
                                                 to.geolocation).centroid  # Midpoint between start end end points
            search_radius_w_tolerance = (
                                            start_end_dist + user_prefs.search_radius) / 2.0  # Retailer search circle radius with user defined tolerance

            converted_list, retailer_count, item_quantity_list = tools.convert_to_markets_for_items_list(active_list,
                                                                                                         start_end_midpoint,
                                                                                                         search_radius_w_tolerance)

            route_dicts, champ_indexes = init_optimization(
                converted_list, item_quantity_list,
                len(item_quantity_list),
                retailer_count, frm.geolocation, to.geolocation,
                [user_prefs.money_factor, user_prefs.dist_factor, user_prefs.time_factor], user_prefs.algorithm)

            routes = []
            for i in range(0, len(route_dicts)):
                stopover_coords = []  # Create a route coord list from response
                stopover_names = []  # Create a route name list from response
                stopover_ids = []

                stopover_coords.append(frm.geolocation.coords)
                stopover_names.append(frm.name)
                for retailer in list(route_dicts[i]['retailers']):
                    stopover_coords.append(retailer.geolocation.coords)
                    stopover_names.append(retailer.name)
                    stopover_ids.append(retailer.id)
                stopover_coords.append(to.geolocation.coords)
                stopover_names.append(to.name)

                retailer_names = []
                retailer_ids = []
                product_names = []
                product_ids = []
                product_prices = []
                product_quantities = []

                for retailer in list(route_dicts[i]['retailers']):
                    retailer_names.append(retailer.name)
                    retailer_ids.append(retailer.id)

                j = 0
                for product in list(route_dicts[i]['products']):
                    product_names.append(product.name)
                    product_ids.append(product.id)
                    product_prices.append(models.RetailerProduct.objects.get(retailer=route_dicts[i]['retailers'][j],
                                                                             baseProduct=product).unitPrice)
                    product_quantities.append(
                        models.ShoppingListItem.objects.get(list=active_list, product=product).quantity)
                    j += 1

                routes.append(
                    {'retailer_names': retailer_names, 'retailer_ids': retailer_ids, 'product_names': product_names,
                     'product_ids': product_ids,
                     'stopover_coords': tools.convert_to_unique_list(stopover_coords),
                     'stopover_names': tools.convert_to_unique_list(stopover_names),
                     'stopover_ids': tools.convert_to_unique_list(stopover_ids),
                     'product_prices': product_prices,
                     'product_quantities': product_quantities,
                     'costs': route_dicts[i]['costs'], 'money_diff': route_dicts[i]['money_diff'],
                     'dist_diff': route_dicts[i]['dist_diff'], 'time_diff': route_dicts[i]['time_diff']})

            return JsonResponse({'routes': routes, 'champ_indexes': champ_indexes})

        elif request.POST.get("complete_shopping_list"):
            active_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            active_list = active_user.active_list

            active_list.total_distance_cost = request.POST.get("distance_cost")
            active_list.total_money_cost = request.POST.get("money_cost")
            active_list.total_time_cost = request.POST.get("time_cost")

            # Update each item in this shopping list
            for i in range(0, len(json.loads(request.POST.get("product_ids")))):
                base_product_id = json.loads(request.POST.get("product_ids"))[i]
                unit_price = json.loads(request.POST.get("product_prices"))[i]
                retailer_id = int(json.loads(request.POST.get("retailer_ids"))[i])

                base_product = models.BaseProduct.objects.get(id=base_product_id)
                list_item = models.ShoppingListItem.objects.get(product=base_product, list=active_list)
                list_item.is_purchased = True
                list_item.purchased_by = active_user
                list_item.purchased_from = models.Retailer.objects.get(id=retailer_id)
                list_item.unit_purchase_price = unit_price
                list_item.purchase_date = datetime.now(tzlocal())
                list_item.save()

            # Shopping list is completed, mark as completed.
            active_list.completed = True
            active_list.completed_by = active_user
            active_list.save()

            message = "Successfully completed the shopping list: <b>%s</b>" % active_list.name
            return JsonResponse({'status': 'success', 'message': message})


def shop(request):
    try:
        session_user = request.session['user_login_session']  # Get login information from current browser session
    except KeyError:
        return render(request, 'gisModule/login.html')

    # Standard GET request for view
    if request.method == "GET":
        root_product_groups = models.ProductGroup.objects.filter(parent=None)
        category_name_list = {}
        for root in root_product_groups:
            category_name_list.update({root.name: json.dumps(tools.iterate_product_groups(root))})
        category_id_list = {}
        for category in models.ProductGroup.objects.all():
            category_id_list.update({category.name: str(category.id)})

        return render(request, 'gisModule/shop.html',
                      {'title': 'Shop', 'category_name_list': tools.jsonify_dict(category_name_list),
                       'category_id_list': tools.jsonify_dict(category_id_list),
                       'user_info': tools.jsonify_str(
                           request.session['user_login_session'])})

    # Handle AJAX Post Requests
    if request.method == "POST":
        if request.POST.get("post_load_products"):
            category_id = request.POST.get("category_id")
            group = models.ProductGroup.objects.get(id=category_id)
            products = {}
            for product in models.BaseProduct.objects.filter(group=group):
                products.update({product.name: product.id})
            return JsonResponse({'loaded_products': products, 'category_id': category_id})

        elif request.POST.get('post_add_to_cart'):
            product = models.BaseProduct.objects.get(id=request.POST.get('product_id'))
            editing_user = models.User.objects.get(id=request.session['user_login_session']['id'])
            shopping_list = editing_user.active_list

            # If no shopping list exists, create new one
            if shopping_list is None:
                temp_list = models.ShoppingList.objects.create(name="My First Shopping List")
                editing_user.active_list = temp_list
                editing_user.save()
                role = models.Role.objects.get(name="Admin")  # TODO
                models.ShoppingListMember.objects.create(user=editing_user, list=editing_user.active_list, role=role)
                shopping_list = temp_list

            list_product, exists, new_quantity = tools.add_product_to_list(editing_user, product, shopping_list)

            # Notify other users sharing the cart
            if exists:
                notification = "<b>%s</b> has changed the quantity of <b>%s</b> as <b>%s</b> in <b>%s</b>" % (
                    editing_user.username, product.name, new_quantity, shopping_list.name)
            else:
                notification = "<b>%s</b> has added a <b>%s</b> into <b>%s</b>" % (
                    editing_user.username, product.name, shopping_list.name)
            for user_shopping_list in models.ShoppingListMember.objects.filter(list=shopping_list):
                notify_id = user_shopping_list.user.id
                if user_shopping_list.user.id != editing_user.id:  # Except current user
                    # Notify if cart is active on others users or their settings allow notifications from other carts
                    if not user_shopping_list.user.preferences.get_notif_only_for_active_list or user_shopping_list.list.id == user_shopping_list.user.active_list.id:
                        pusher_client.trigger('%s' % notify_id, 'product_add',
                                              {'message': notification, 'product_name': product.name,
                                               'product_id': request.POST.get('product_id'),
                                               'product_quantity': list_product.quantity,
                                               'product_added_by': list_product.added_by.username,
                                               'product_changed_by': list_product.edited_by.username})

            message = "Product successfully added into shopping list"
            return JsonResponse({'status': 'success', 'message': message})

        elif request.POST.get('post_search_product'):
            search_text = request.POST.get('search_text').split()
            queryset = models.BaseProduct.objects.all()
            for string in search_text:
                queryset = queryset.filter(name__icontains=string)
            products = {}
            for product in queryset:
                products.update({product.name: product.id})
            return JsonResponse({'loaded_products': products})

        elif request.POST.get('fetch_product_details'):
            product = models.BaseProduct.objects.all().get(id=request.POST.get('product_id'))
            retailer_prices = []
            avg_price = 0
            i = 0
            for retailer_product in models.RetailerProduct.objects.all().filter(baseProduct=product):
                if retailer_product.removed_from_store:
                    continue

                retailer_prices.append(
                    {'retailer_product_id': retailer_product.id, 'retailer_name': retailer_product.retailer.name
                        , 'retailer_price': retailer_product.unitPrice})
                avg_price += retailer_product.unitPrice
                i += 1

            no_retailers = False
            if len(retailer_prices) == 0:
                no_retailers = True

            return JsonResponse(
                {'product_name': product.name, 'product_id': product.id, 'retailer_prices': retailer_prices,
                 'no_retailers': no_retailers})

        elif request.POST.get('blame_retailer'):
            user = models.User.objects.get(id=request.session['user_login_session']['id'])
            retailer_product = models.RetailerProduct.objects.get(id=request.POST.get('retailer_product_id'))

            result, message = BlameModule.new_blame(retailer_product, user)
            if result:
                return JsonResponse({'status': 'success', 'message': message})
            else:
                return JsonResponse({'status': 'error', 'message': message})


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

                    new_stats = models.UserStatistics.objects.create(
                        reputation=BlameModule.parameters.INITIAL_REPUTATION_FOR_USER)

                    new_usr = models.User.objects.create(username=username,
                                                         password=tools.encode_password(request.POST.get("password")),
                                                         email=email, first_name=first_name, last_name=last_name,
                                                         preferences=new_prefs, statistics=new_stats, active_list=None)

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
