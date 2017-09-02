/**
 * Created by dyanikoglu on 12.05.2017.
 */

$(document).ready(function () {
    $('#settings_header').html('Account | Statistics');
    fetch_statistics();

    $('#received_proposals_button').click(function () {
        hide_all();
        $('#settings_header').html('Account | Received Proposals');
        $('#received_proposals').toggle('normal');
        fetch_pending_proposals();
        return false;
    });

    $('#statistics_button').click(function () {
        hide_all();
        $('#statistics').toggle('normal');
        $('#settings_header').html('Account | Statistics');
        fetch_statistics();
        return false;
    });

    $('#route_default_settings_button').click(function () {
        hide_all();
        $('#settings_header').html('Route | Default Settings');
        $('#route_defaults_settings').toggle('normal');
        fetch_route_default_settings();
        return false;
    });

    $('#save_route_defaults_button').click(function () {
        save_route_defaults($(this).closest('form').serialize());
        return false;
    });

    $('#address_book_button').click(function () {
        hide_all();
        $('#settings_header').html('Route | Address Book');
        $('#address_book').toggle('normal');
        fetch_addresses();
        return false;
    });

    $('#create_address_button').click(function () {
        if (!$('#address_name').val()) {
            show_account_notif("<b>Address Name</b> field can\'t be empty", 2000);
            return false;
        }
        create_address_entry($(this).closest('form').serialize());
        return false;
    });

    $('#account_general_settings_button').click(function () {
        hide_all();
        $('#settings_header').html('Account | General Settings');
        $('#account_general_settings').toggle('normal');
        return false;
    });


    $('#manage_friends_button').click(function () {
        load_account_friend_management();
        return false;
    });

    $('#add_friend_button').click(function () {
        $('#add_friend_form').toggle('normal');
        return false;
    });

    $('#add_as_friend_button').click(function () {
        send_friend_request($(this).closest('form').serialize());
        return false;
    });


    $('#add_group_button').click(function () {
        $('#add_group_form').toggle('normal');
        return false;
    });

    $('#manage_groups_button').click(function () {
        load_account_group_management();
        return false;
    });

    $('#create_group_button').click(function () {
        create_new_group($(this).closest('form').serialize());
        return false;
    });


    $('#manage_lists_button').click(function () {
        load_shopping_list_management();
        return false;
    });

    $('#add_list_button').click(function () {
        $('#add_list_form').toggle('normal');
        return false;
    });

    $('#create_list_button').click(function () {
        create_new_list($(this).closest('form').serialize());
        return false;
    });

    google.charts.load('current', {'packages': ['corechart']});
    google.charts.setOnLoadCallback(drawCharts);
});

function hide_all() {
    $('#account_general_settings').hide('normal');
    $('#account_friend_management').hide('normal');
    $('#account_group_management').hide('normal');
    $('#list_management').hide('normal');
    $('#route_defaults_settings').hide('normal');
    $('#address_book').hide('normal');
    $('#received_proposals').hide('normal');
    $('#statistics').hide('normal');
}

///////////////////// ROUTE DEFAULTS START
function fetch_route_default_settings() {
    $.ajax({
        type: "POST",
        data: {'fetch_route_default_settings': 'fetch_route_default_settings'},
        success: function (data) {
            console.log(data['opt_money'])
            $('#opt_money').prop('checked', data['opt_money']);
            $('#opt_dist').prop('checked', data['opt_dist']);
            $('#opt_time').prop('checked', data['opt_time']);
            $('#default_tolerance').val(data['tolerance']);

            var default_start_point = $('#default_start_point');
            var default_end_point = $('#default_end_point');
            default_start_point.empty();
            default_end_point.empty();

            default_start_point.append('<option value="-1">- Select -</option>');
            default_end_point.append('<option value="-1">- Select -</option>');

            for (var i = 0; i < data['addresses'].length; i++) {
                default_start_point.append('<option value="' + data['addresses'][i]['address_id'] + '">' + data['addresses'][i]['address_name'] + '</option>')
                default_end_point.append('<option value="' + data['addresses'][i]['address_id'] + '">' + data['addresses'][i]['address_name'] + '</option>')
            }

            default_start_point.val(data['start_point_id']).change();
            default_end_point.val(data['end_point_id']).change();
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function save_route_defaults(serialized_form) {
    serialized_form += "&save_route_defaults=save_route_defaults";
    $.ajax({
        type: "POST",
        data: serialized_form,
        success: function (data) {
            show_account_notif(data['message'], 2000);
            fetch_route_default_settings();
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

///////////////////// ROUTE DEFAULTS END

///////////////////// ADDRESS BOOK START
function create_address_entry(serialized_form) {


    serialized_form += "&create_address_entry=create_address_entry";
    $.ajax({
        type: "POST",
        data: serialized_form,
        success: function (data) {
            show_account_notif(data['message'], 2000);
            fetch_addresses();
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function fetch_addresses() {
    $.ajax({
        type: "POST",
        data: {'fetch_addresses': 'fetch_addresses'},
        success: function (data) {
            var saved_addresses = $('#saved_addresses');
            saved_addresses.empty();
            for (var i = 0; i < data['addresses'].length; i++) {
                saved_addresses.append('<div class="row"> <div class="col-sm-2">' + data['addresses'][i]['address_name'] + '</div> <div class="col-sm-8">' + data['addresses'][i]['address'] + '</div> <div class="col-sm-1"> <button onclick="remove_address(' + data['addresses'][i]['address_id'] + ');return false;" class="btn btn-primary">X</button> </div> </div>');
            }
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function remove_address(address_id) {
    $.ajax({
        type: "POST",
        data: {'remove_address': 'remove_address', 'address_id': address_id},
        success: function (data) {
            show_account_notif(data['message'], 2000);
            fetch_addresses();
        },
        error: function (xhr, ajaxOptions, thrownError) {
            fetch_addresses();
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

///////////////////// ADDRESS BOOK END


///////////////////// SHOPPING LIST MANAGEMENT START
function load_shopping_list_management() {
    hide_all();
    fetch_shopping_lists();
    $('#list_management').show('normal');
    $('#settings_header').html('Shopping List Management');
}

function create_new_list(serialized_form) {
    serialized_form += "&create_new_list=create_new_list";
    $.ajax({
        type: "POST",
        data: serialized_form,
        success: function (data) {
            show_account_notif(data['message'], 2000);
            fetch_shopping_lists();
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function quit_from_list(list_id, user_id) {
    $.ajax({
        type: "POST",
        data: {'quit_from_list': 'quit_from_list', 'list_id': list_id, 'user_id': user_id},
        success: function (data) {
            show_account_notif(data['message'], 2000);
            fetch_shopping_lists();
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function remove_from_list(list_id, user_id) {
    $.ajax({
        type: "POST",
        data: {'remove_from_list': 'remove_from_list', 'list_id': list_id, 'user_id': user_id},
        success: function (data) {
            show_account_notif(data['message'], 2000);
            fetch_shopping_lists();
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function add_to_list(list_id) {
    var serialized_form = $('#add_to_list_form_' + list_id).serialize();
    serialized_form += "&list_id=" + list_id + "&add_to_list=add_to_list";
    $.ajax({
        type: "POST",
        data: serialized_form,
        success: function (data) {
            show_account_notif(data['message'], 2000);
            fetch_shopping_lists();
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function fetch_shopping_lists() {
    $.ajax({
        type: "POST",
        data: {'fetch_shopping_lists': 'fetch_shopping_lists'},
        success: function (data) {
            var list_list = $('#list_list');
            list_list.empty();
            for (var i = 0; i < data['lists'].length; i++) {
                if (data['lists'][i]['active_role'] === 'Admin') {
                    var onclick_val = "$('#add_to_list_" + data['lists'][i]['list_id'] + "').toggle('normal'); return false;";
                    list_list.append('<br><h2>' + data['lists'][i]['list_name'] + '<a onclick="' + onclick_val + '" href="#">+</a></h2>');
                    list_list.append('<div id="add_to_list_' + data['lists'][i]['list_id'] + '" class="row" hidden> <br> <form id="add_to_list_form_' + data['lists'][i]['list_id'] + '" method="post"> <div class="col-sm-3"> <div class="blank-arrow"> <label>User Name</label> </div> <select id="add_to_list_select_' + data['lists'][i]['list_id'] + '" name="user_id" type="text"></select> </div> <div class="col-sm-2"> <button type="button" onclick="add_to_list(' + data['lists'][i]['list_id'] + ');" class="btn btn-primary">Add to List</button> </div> </form> </div>');
                    var select_user = $('#add_to_list_select_' + data['lists'][i]['list_id']);
                    for (var k = 0; k < data['friends'].length; k++) {
                        select_user.append('<option value="' + data['friends'][k]['user_id'] + '">' + data['friends'][k]['username'] + '</option>');
                    }
                } else {
                    list_list.append('<br><h2>' + data['lists'][i]['list_name'] + '</h2>');
                }


                for (var j = 0; j < data['lists'][i]['members'].length; j++) {
                    if (data['lists'][i]['members'][j]['user_id'] === user_info['id']) { // Our membership
                        list_list.append('<div class="row"> <div class="col-sm-3"> <span>' + data['lists'][i]['members'][j]['username'] + '</span> </div> <div class="col-sm-3"> <span>' + data['lists'][i]['members'][j]['name'] + '</span> </div> <div class="col-sm-3"> <span>' + '</span> </div> <div class="col-sm-2"> <button type="submit" onclick="quit_from_list(' + data['lists'][i]['list_id'] + ',' + data['lists'][i]['members'][j]['user_id'] + '); return false;" class="btn btn-primary">Quit From List</button> </div> </div> </div>');
                    }
                    else if (data['lists'][i]['active_role'] === 'Admin') {
                        list_list.append('<div class="row"> <div class="col-sm-3"> <span>' + data['lists'][i]['members'][j]['username'] + '</span> </div> <div class="col-sm-3"> <span>' + data['lists'][i]['members'][j]['name'] + '</span> </div> <div class="col-sm-3"> <span>' + '</span> </div> <div class="col-sm-2"> <button type="submit" onclick="remove_from_list(' + data['lists'][i]['list_id'] + ',' + data['lists'][i]['members'][j]['user_id'] + '); return false;" class="btn btn-primary">Remove From List</button> </div> </div> </div>');
                    }
                    else { // Other members
                        list_list.append('<div class="row"> <div class="col-sm-3"> <span>' + data['lists'][i]['members'][j]['username'] + '</span> </div> <div class="col-sm-3"> <span>' + data['lists'][i]['members'][j]['name'] + '</span> </div> <div class="col-sm-3"> <span>' + '</span> </div> <div class="col-sm-4"> </div> </div> </div>');
                    }
                }
            }
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

///////////////////// SHOPPING LIST MANAGEMENT END


///////////////////// GROUP MANAGEMENT START
function load_account_group_management() {
    hide_all();
    fetch_group_list();
    $('#account_group_management').show('normal');
    $('#settings_header').html('Group Management');
}

function create_new_group(serialized_form) {
    serialized_form += "&create_new_group=create_new_group";
    $.ajax({
        type: "POST",
        data: serialized_form,
        success: function (data) {
            show_account_notif(data['message'], 2000);
            fetch_group_list();
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function quit_from_group(group_id, user_id) {
    $.ajax({
        type: "POST",
        data: {'quit_from_group': 'quit_from_group', 'group_id': group_id, 'user_id': user_id},
        success: function (data) {
            show_account_notif(data['message'], 2000);
            fetch_group_list();
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function remove_from_group(group_id, user_id) {
    $.ajax({
        type: "POST",
        data: {'remove_from_group': 'remove_from_group', 'group_id': group_id, 'user_id': user_id},
        success: function (data) {
            show_account_notif(data['message'], 2000);
            fetch_group_list();
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function add_to_group(group_id) {
    var serialized_form = $('#add_to_group_form_' + group_id).serialize();
    serialized_form += "&group_id=" + group_id + "&add_to_group=add_to_group";
    $.ajax({
        type: "POST",
        data: serialized_form,
        success: function (data) {
            show_account_notif(data['message'], 2000);
            fetch_group_list();
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function fetch_group_list() {
    $.ajax({
        type: "POST",
        data: {'fetch_group_list': 'fetch_group_list'},
        success: function (data) {
            var group_list = $('#group_list');
            group_list.empty();
            for (var i = 0; i < data['groups'].length; i++) {
                if (data['groups'][i]['active_role'] === 'Admin') {
                    var onclick_val = "$('#add_to_group_" + data['groups'][i]['group_id'] + "').toggle('normal'); return false;";
                    group_list.append('<br><h2>' + data['groups'][i]['group_name'] + '<a onclick="' + onclick_val + '" href="#">+</a></h2>');
                    group_list.append('<div id="add_to_group_' + data['groups'][i]['group_id'] + '" class="row" hidden> <br> <form id="add_to_group_form_' + data['groups'][i]['group_id'] + '" method="post"> <div class="col-sm-3"> <div class="blank-arrow"> <label>User Name</label> </div> <select id="add_to_group_select_' + data['groups'][i]['group_id'] + '" name="user_id" type="text"></select> </div> <div class="col-sm-2"> <button type="button" onclick="add_to_group(' + data['groups'][i]['group_id'] + ');" class="btn btn-primary">Add to Group</button> </div> </form> </div>');
                    var select_user = $('#add_to_group_select_' + data['groups'][i]['group_id']);
                    for (var k = 0; k < data['friends'].length; k++) {
                        select_user.append('<option value="' + data['friends'][k]['user_id'] + '">' + data['friends'][k]['username'] + '</option>');
                    }
                } else {
                    group_list.append('<br><h2>' + data['groups'][i]['group_name'] + '</h2>');
                }


                for (var j = 0; j < data['groups'][i]['members'].length; j++) {
                    if (data['groups'][i]['members'][j]['user_id'] === user_info['id']) { // Our membership
                        group_list.append('<div class="row"> <div class="col-sm-3"> <span>' + data['groups'][i]['members'][j]['username'] + '</span> </div> <div class="col-sm-3"> <span>' + data['groups'][i]['members'][j]['name'] + '</span> </div> <div class="col-sm-3"> <span>' + data['groups'][i]['members'][j]['join_date'] + '</span> </div> <div class="col-sm-2"> <button type="submit" onclick="quit_from_group(' + data['groups'][i]['group_id'] + ',' + data['groups'][i]['members'][j]['user_id'] + '); return false;" class="btn btn-primary">Quit From Group</button> </div> </div> </div>');
                    }
                    else if (data['groups'][i]['active_role'] === 'Admin') {
                        group_list.append('<div class="row"> <div class="col-sm-3"> <span>' + data['groups'][i]['members'][j]['username'] + '</span> </div> <div class="col-sm-3"> <span>' + data['groups'][i]['members'][j]['name'] + '</span> </div> <div class="col-sm-3"> <span>' + data['groups'][i]['members'][j]['join_date'] + '</span> </div> <div class="col-sm-2"> <button type="submit" onclick="remove_from_group(' + data['groups'][i]['group_id'] + ',' + data['groups'][i]['members'][j]['user_id'] + '); return false;" class="btn btn-primary">Remove From Group</button> </div> </div> </div>');
                    }
                    else { // Other members
                        group_list.append('<div class="row"> <div class="col-sm-3"> <span>' + data['groups'][i]['members'][j]['username'] + '</span> </div> <div class="col-sm-3"> <span>' + data['groups'][i]['members'][j]['name'] + '</span> </div> <div class="col-sm-3"> <span>' + data['groups'][i]['members'][j]['join_date'] + '</span> </div> <div class="col-sm-4"> </div> </div> </div>');
                    }
                }
            }
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

///////////////////// GROUP MANAGEMENT END


///////////////////// FRIEND MANAGEMENT START
function load_account_friend_management() {
    hide_all();
    fetch_friend_list();
    fetch_pending_friend_requests();
    fetch_received_friend_requests();
    $('#account_friend_management').show('normal');
    $('#settings_header').html('Friend Management');
}

function send_friend_request(serialized_form) {
    serialized_form += "&send_friend_request=send_friend_request";
    $.ajax({
        type: "POST",
        data: serialized_form,
        success: function (data) {
            show_account_notif(data['message'], 2000);
            fetch_pending_friend_requests();
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function fetch_pending_friend_requests() {
    $.ajax({
        type: "POST",
        data: {'fetch_pending_friend_requests': 'fetch_pending_friend_requests'},
        success: function (data) {
            var pending_friend_requests = $('#pending_friend_requests');
            pending_friend_requests.empty();
            for (var i = 0; i < data['pending_requests'].length; i++) {
                pending_friend_requests.append('<div class="row"> <div class="col-sm-3"> <span>' + data['pending_requests'][i]['username'] + '</span> </div> <div class="col-sm-3"> <span>' + data['pending_requests'][i]['name'] + '</span> </div> <div class="col-sm-3"> <span>' + data['pending_requests'][i]['date'] + '</span> </div> <div class="col-sm-2"> <button type="submit" onclick="cancel_friend_request(' + data['pending_requests'][i]['request_id'] + '); return false;" class="btn btn-primary">Cancel</button> </div> </div>');
            }
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function deny_friend_request(request_id) {
    $.ajax({
        type: "POST",
        data: {'deny_friend_request': 'deny_friend_request', 'request_id': request_id},
        success: function (data) {
            show_account_notif(data['message'], 2000);
            fetch_received_friend_requests();
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function cancel_friend_request(request_id) {
    $.ajax({
        type: "POST",
        data: {'cancel_friend_request': 'cancel_friend_request', 'request_id': request_id},
        success: function (data) {
            show_account_notif(data['message'], 2000);
            fetch_pending_friend_requests();
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function remove_friend(request_id) {
    $.ajax({
        type: "POST",
        data: {'remove_friend': 'remove_friend', 'request_id': request_id},
        success: function (data) {
            show_account_notif(data['message'], 2000);
            fetch_friend_list();
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function accept_friend_request(request_id) {
    $.ajax({
        type: "POST",
        data: {'accept_friend_request': 'accept_friend_request', 'request_id': request_id},
        success: function (data) {
            show_account_notif(data['message'], 2000);
            fetch_friend_list();
            fetch_received_friend_requests();
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function fetch_received_friend_requests() {
    $.ajax({
        type: "POST",
        data: {'fetch_received_friend_requests': 'fetch_received_friend_requests'},
        success: function (data) {
            var received_friend_requests = $('#received_friend_requests');
            received_friend_requests.empty();
            for (var i = 0; i < data['received_requests'].length; i++) {
                received_friend_requests.append('<div class="row"> <div class="col-sm-3"> <span>' + data['received_requests'][i]['username'] + '</span> </div> <div class="col-sm-3"> <span>' + data['received_requests'][i]['name'] + '</span> </div> <div class="col-sm-3"> <span>' + data['received_requests'][i]['date'] + '</span> </div> <div class="col-sm-1"> <button onclick="accept_friend_request(' + data['received_requests'][i]['request_id'] + '); return false;" class="btn btn-primary" href="#">Accept</button> </div> <div class="col-sm-1"> <button onclick="deny_friend_request(' + data['received_requests'][i]['request_id'] + '); return false;" class="btn btn-primary" href="#">Deny</button> </div> </div>');
            }
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function fetch_friend_list() {
    $.ajax({
        type: "POST",
        data: {'fetch_friend_list': 'fetch_friend_list'},
        success: function (data) {
            var friend_list = $('#friend_list');
            friend_list.empty();
            for (var i = 0; i < data['friends'].length; i++) {
                friend_list.append('<div class="row"> <div class="col-sm-3"> <span>' + data['friends'][i]['username'] + '</span> </div> <div class="col-sm-3"> <span>' + data['friends'][i]['name'] + '</span> </div> <div class="col-sm-3"> <span>' + data['friends'][i]['date'] + '</span> </div> <div class="col-sm-2"> <button type="submit" onclick="remove_friend(' + data['friends'][i]['request_id'] + '); return false;" class="btn btn-primary">Remove Friend</button> </div> </div> </div>');
            }
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

///////////////////// FRIEND MANAGEMENT END


//////////////////// FALSE PRICE PROPOSAL MANAGEMENT START

function fetch_pending_proposals() {
    $.ajax({
        type: "POST",
        data: {'fetch_pending_proposal': 'fetch_pending_proposal'},
        success: function (data) {
            var received_proposals = $('#received_proposals');
            received_proposals.empty();

            // Fill prices for each retailer
            var all_prices_table = $('#all_prices');
            all_prices_table.empty();
            received_proposals.append('<h3 style="color: darkorange">Other Prices Of This Product:</h3>');
            received_proposals.append('<div class="tab-content"><div class="datagrid"><table><thead> <tr><th>Retailer Name<br></th> <th>Unit Price</th></tr></thead><tbody id="all_prices">');
            for (var i = 0; i < data['other_prices'].length; i++) {
                received_proposals.append('<tr><td>' + data['other_prices'][i]['retailer_name'] + '</td><td>' + data['other_prices'][i]['retailer_price'] + '</td></tr>');
            }
            received_proposals.append('</tbody></table></div></div>')
            received_proposals.append('<h3 style="color: darkorange">Reported Retailer Name:</h3> <h5>' + data['related_retailer_name'] + '</h5>');
            received_proposals.append('<h3 style="color: darkorange">Reported Product:</h3> <h5>' + data['related_product_name'] + '</h5>');
            received_proposals.append('<h3 style="color: darkorange">Reported Price Of The Product:</h3> <h5>' + data['related_product_price'] + 'TL</h5>');
            received_proposals.append('<h3 style="color: darkorange">Your Reply:</h3> <button onclick="send_reply_to_proposal(' + data['sent_proposal_id'] + ', ' + true + '); return false;">False Price</button> <button onclick="send_reply_to_proposal(' + data['sent_proposal_id'] + ', ' + false + '); return false;">Not False Price</button>');
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
            var received_proposals = $('#received_proposals');
            received_proposals.empty();
            received_proposals.append('<h3>No pending proposal available</h3>');
        }
    });
}

function send_reply_to_proposal(proposal_id, response) {
    $.ajax({
        type: "POST",
        data: {'send_reply_to_proposal': 'send_reply_to_proposal', 'proposal_id': proposal_id, 'response': response},
        success: function (data) {
            show_account_notif(data['message'], 2000);
            fetch_pending_proposals(); // Fetch next available proposal if it exist
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

//////////////////// FALSE PRICE PROPOSAL MANAGEMENT END


/////////////////// STATISTICS START

function fetch_statistics() {
    // TODO Add favorite retailer

    $.ajax({
        type: "POST",
        data: {'fetch_statistics': 'fetch_statistics'},
        success: function (data) {
            $('#total_blames').empty();
            $('#total_products').empty()
            $('#total_shopping_lists').empty();
            $('#favorite_category').empty();
            $('#favorite_retailer').empty();
            $('#favorite_product').empty();
            $('#reputation').empty();

            $('#reputation').append(data['reputation']);
            $('#total_blames').append(data['total_blames']);
            $('#total_products').append(data['total_products']);
            $('#total_shopping_lists').append(data['total_shopping_lists']);
            if (data['favorite_category']) {
                $('#favorite_category_toggle').show();
                $('#favorite_category').append(data['favorite_category']);
            } else {
                $('#favorite_category_toggle').hide();
            }
            if (data['favorite_product']) {
                $('#favorite_product_toggle').show();
                $('#favorite_product').append(data['favorite_product']);
            } else {
                $('#favorite_product_toggle').hide();
            }
            if (data['favorite_retailer']) {
                $('#favorite_retailer_toggle').show();
                $('#favorite_retailer').append(data['favorite_retailer']);
            } else {
                $('#favorite_retailer_toggle').hide();
            }
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function drawCharts() {
    // Total Money Spent Per Category
    $.ajax({
        type: "POST",
        data: {'fetch_categorical_statistics': 'fetch_categorical_statistics'},
        success: function (data) {
            drawPieChart(data['keys'], data['values'], data['key_name'], data['value_name'], data['title'], 'category_price_chart');
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });

    // Total Money Spent Per Retailer
    $.ajax({
        type: "POST",
        data: {'fetch_retailer_price_stats': 'fetch_retailer_price_stats'},
        success: function (data) {
            drawPieChart(data['keys'], data['values'], data['key_name'], data['value_name'], data['title'], 'retailer_price_chart');
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });

    // Total Items Purchased Per Category
    $.ajax({
        type: "POST",
        data: {'fetch_category_item_count_stats': 'fetch_category_item_count_stats'},
        success: function (data) {
            drawPieChart(data['keys'], data['values'], data['key_name'], data['value_name'], data['title'], 'category_count_chart');
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });

    // Total Items Purchased Per Retailer
    $.ajax({
        type: "POST",
        data: {'fetch_retailer_item_count_stats': 'fetch_retailer_item_count_stats'},
        success: function (data) {
            drawPieChart(data['keys'], data['values'], data['key_name'], data['value_name'], data['title'], 'retailer_count_chart');
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function drawPieChart(keys, values, key_name, value_name, title, div_id) {
    var price_array = values; // value
    var category_array = keys; // key
    var result_array = [[key_name, value_name]]; // [key_name, value_name]
    for (var i = 0; i < price_array.length; i++) {
        var tempArr = [];
        tempArr.push(category_array[i]);
        tempArr.push(parseFloat(price_array[i]));
        result_array.push(tempArr);
    }
    var data = google.visualization.arrayToDataTable(result_array);
    var options = {title: title};
    var chart = new google.visualization.PieChart(document.getElementById(div_id));
    chart.draw(data, options);
}

/////////////////// STATISTICS END


function show_account_notif(msg, time) {
    var account_notification = $('#account_notification');
    account_notification.attr('data-original-title', msg).tooltip("show");
    setTimeout(function () {
        $('#account_notification').tooltip('hide');
    }, time);
}