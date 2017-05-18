/**
 * Created by dyanikoglu on 10.05.2017.
 */

$(document).ready(function () {
    fetch_cart_data();
    fetch_route_defaults();

    $('#save_as_default_button').click(function () {
        save_as_route_defaults($(this).closest('form').serialize());
        return false;
    });

    $('#calculate_routes_button').click(function () {
        $('#cart_items').hide('slow');
        $('#do_action').hide('slow');
        $('#footer').hide('slow');
        $('#loading').show('slow');

        initiate_route_calculation();

        setTimeout(function () {
            $('#calculating_text').append('.');
        }, 1500);
        setTimeout(function () {
            $('#calculating_text').append('.');
        }, 2000);
        setTimeout(function () {
            $('#calculating_text').append('.');
        }, 2500);
        setTimeout(function () {
            $('#calculating_text').append('.');
        }, 3000);
    });

    $('.mobileSelect').mobileSelect({
            padding: {
                top: '15%',
                left: '35%',
                right: '35%',
                bottom: '15%'
            },
            animation: 'zoom',
            onClose: function () {
                $.ajax({
                    type: "POST",
                    data: {
                        'change_active_list': 'change_active_list',
                        'list_id': $('#active_list_selection').find(':selected').val()
                    },
                    success: function (data) {
                        fetch_cart_data();
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        show_cart_notif(xhr['responseJSON']['message'], 2000);
                    }
                });
            },
            onOpen: function () {
                $.ajax({
                    type: "POST",
                    data: {'fetch_shopping_lists': 'fetch_shopping_lists'},
                    success: function (data) {
                        var active_list_selection = $('#active_list_selection');
                        active_list_selection.empty();
                        for (var i = 0; i < data['lists'].length; i++) {
                            if (data['active_list_id'] === data['lists'][i]['list_id']) {
                                active_list_selection.append('<option selected value="' + data['lists'][i]['list_id'] + '">' + data['lists'][i]['list_name'] + '</option>');
                            } else {
                                active_list_selection.append('<option value="' + data['lists'][i]['list_id'] + '">' + data['lists'][i]['list_name'] + '</option>');
                            }
                        }
                        active_list_selection.mobileSelect('refresh');
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        show_cart_notif(xhr['responseJSON']['message'], 2000);
                    }
                });
            }

        }
    );
});

function initiate_route_calculation() {
    $.ajax({
        type: "POST",
        data: {'initiate_route_calculation': 'initiate_route_calculation'},
        success: function (data) {
            console.log(data);
            $('#loading').hide('slow');
            var route_selection = $('#route_selection');
            fill_route_data(data);
            route_selection.show('slow');
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_cart_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function fill_route_data(data) {
    var champ_routes = $("#champ_routes");
    champ_routes.empty();
    var other_routes = $("#other_routes");
    other_routes.empty();

    var routes = data['routes'];
    var m_champ_ind = data['champ_indexes'][0]; // Money champ index in data['routes']
    var d_champ_ind = data['champ_indexes'][1]; // Distance champ index in data['routes']
    var t_champ_ind = data['champ_indexes'][2]; // Time champ index in data['routes']
    var r_champ_ind = data['champ_indexes'][3]; // Reasonable route index in data['routes']
    var route_indexing = 1;
    for (var i = 0; i < routes.length; i++) {
        var current_route = routes[i];

        // Put the route to other routes section
        if (i !== m_champ_ind || i !== d_champ_ind || i !== t_champ_ind || i !== r_champ_ind) {
            other_routes.append('<div id="route_main_' + i + '"></div>');
            var main = $('#route_main_' + i);

            main.append('<br><br><br><h2 style="color: orange">Other Route - ' + route_indexing++ + '</h2>');

            other_routes.append('<div id="route_details_' + i + '"></div>');
            var details = $('#route_details_' + i);
            details.append('<div class="row" id="route_details_retailers_' + i + '"></div>')
            var retailers = $('#route_details_retailers_' + i);

            // Show retailers to visit
            for (var j = 1; j < current_route['stopover_names'].length - 1; j++) {
                retailers.append('<span><img style="width: 2em; height: 2em;" src="http://housing.utk.edu/wp-content/uploads/sites/12/2016/10/Tour2.png"></span>' + current_route['stopover_names'][j] + '&nbsp; &nbsp; &nbsp;');
            }

            var time_value = current_route['costs'][2] * 60;
            var hours = parseInt(time_value / 60);
            var minutes = parseInt(time_value % 60);
            retailers.append('<div class="row"><span><img style="width: 2em; height: 2em;" src="https://i.hizliresim.com/LyrOqj.png"></span>&nbsp;' + current_route['costs'][0] + '&nbsp;TL&nbsp;&nbsp;&nbsp;&nbsp; <img style="width: 2em; height: 2em;" src="https://image.flaticon.com/icons/png/128/31/31126.png"></span>&nbsp;' + current_route['costs'][1].toFixed(2) + '&nbsp;KM&nbsp;&nbsp;&nbsp;&nbsp;<span><img style="width: 2em; height: 2em;" src="http://wcdn3.dataknet.com/static/resources/icons/set110/f112ae8c.png"></span>&nbsp;' + hours + 'h&nbsp;' + minutes + 'm</div>');



            var is_money_optimized = true;
            var is_dist_optimized = true;
            var is_time_optimized = true;
            if (parseInt(current_route['money_diff']) !== 0) {
                is_money_optimized = false;
            }
            if (parseInt(current_route['dist_diff']) !== 0) {
                is_dist_optimized = false;
            }
            time_value = current_route['time_diff'] * 60;
            hours = parseInt(time_value / 60);
            minutes = parseInt(time_value % 60);
            if (hours !== 0 || minutes !== 0) {
                is_time_optimized = false;
            }

            if (!is_dist_optimized || !is_money_optimized || !is_time_optimized) {
                retailers.append('<br><h4 style="text-decoration: underline">If you choose this route<h4>');

                if (!is_money_optimized) {
                    retailers.append('<div class="row"><p>You will spend ' + parseInt(current_route['money_diff']) + ' TL more than money optimized route</p></div>');
                }

                if (!is_dist_optimized) {
                    retailers.append('<div class="row"><p>You will travel ' + parseInt(current_route['dist_diff']) + ' KM more than distance optimized route</p></div>');
                }

                if (!is_time_optimized) {
                    var hour_text = "You will shop ";
                    if (hours !== 0) {
                        hour_text += hours + "h ";
                    }
                    if (minutes !== 0) {
                        hour_text += minutes + "min ";
                    }
                    hour_text += "more than time optimized route";
                    retailers.append('<div class="row"><p>' + hour_text + '</p></div>');
                }
            }
        }
    }


    // var products_to_buy = data['products_to_buy'];
    // var champ_indexes = data['champ_indexes'];
    // var money_flag = false;
    // var dist_flag = false;
    // var counts = data['counts'];
    // var time_flag = false;
    // var reasonable_flag = false;
    // var costs = data['costs'];
    // var stopover_names = data['stopover_names'];
    // var pros_cons = data['pros_cons'];
    // var prices = data['prices'];
    // var retailers_to_visit = data['retailers_to_visit'];
    //
    // var i = 0;
    // var j = 0;
    // var k = 0;
    // var other_route_count = 0;
    // var any_champs;
    //
    // var route_title = "";
    // var stopover_names_text = "";
    // var route_pros_cons_text = "";
    // var where_to_buy_text = "";
    //
    //     // Initialize Buy Which Product From Where
    //     where_to_buy_text = '<div class="tg-wrap"><table class="tg" style="undefined;table-layout: fixed; width: 503px"> <colgroup> <col style="width: 206px"> <col style="width: 150px"> <col style="width: 147px"> <col style="width: 147px"> <col style="width: 147px"> </colgroup> <tr> <th class="tg-s6z2">Retailer Name/ Product Info<br></th> <th class="tg-s6z2">Product Name<br></th> <th class="tg-s6z2">Unit Price</th> <th class="tg-s6z2">Count</th> <th class="tg-s6z2">Total Price</th> </tr>';
    //     k = 0;
    //     var unique_retailers = retailers_to_visit[i].filter(onlyUnique);
    //     var retailer_products = [];
    //     var l = 0;
    //     for (k; k < unique_retailers.length; k++) {
    //         retailer_products = [];
    //         retailer_product_prices = [];
    //         l = 0;
    //         for (l; l < retailers_to_visit[i].length; l++) {
    //             if (retailers_to_visit[i][l] === unique_retailers[k]) {
    //                 retailer_products.push(products_to_buy[i][l]);
    //                 retailer_product_prices.push(prices[i][l]);
    //             }
    //         }
    //
    //         temp_product_names.push(retailer_products); // This is required for right panel of map modal
    //
    //         where_to_buy_text += '<tr><td class="tg-s6z2" rowspan="' + retailer_products.length + '">' + unique_retailers[k] + '<br></td>';
    //         where_to_buy_text += '<td class="tg-s6z2">' + retailer_products[0] + '<br></td> <td class="tg-s6z2">' + retailer_product_prices[0] + 'TL' + '</td> <td class="tg-s6z2">' + counts[i][0] + '</td> <td class="tg-s6z2">' + counts[i][0] * retailer_product_prices[0] + 'TL' + '</td> </tr>';
    //
    //         l = 1;
    //         for (l; l < retailer_products.length; l++) {
    //             where_to_buy_text += '<tr> <td class="tg-s6z2">' + retailer_products[l] + '</td> <td class="tg-s6z2">' + retailer_product_prices[l] + 'TL' + '</td> <td class="tg-s6z2">' + counts[i][l] + '</td> <td class="tg-s6z2">' + counts[i][l] * retailer_product_prices[l] + 'TL' + '</td> </tr>'
    //         }
    //     }
    //
    //     items_to_buy_from_retailers.push(temp_product_names);
    //     where_to_buy_text += '</table></div>';
    //
    //     if (any_champs) {
    //         route_title += "Optimized Route";
    //         champ_routes.append('<div class="panel panel-default"> <div class="panel-heading"> <h4 class="panel-title"> <a data-toggle="collapse" data-parent="#accordion" href="#collapse' + i + '">' + route_title + '</a> <button style="float: right" onclick="showGMaps(' + i + ');">Select This Route</button> </h4> </div> <div id="collapse' + i + '" class="panel-collapse collapse"> <div class="panel-body">' + stopover_names_text + "<br>" + route_pros_cons_text + '<br>' + where_to_buy_text + '</div> </div> </div>');
    //     } else {
    //         other_routes.append('<div class="panel panel-default"> <div class="panel-heading"> <h4 class="panel-title"> <a data-toggle="collapse" data-parent="#accordion" href="#collapse' + i + '">' + "Other Route: " + ++other_route_count + '</a> <button style="float: right" onclick="showGMaps(' + i + ');">Select This Route</button> </h4> </div> <div id="collapse' + i + '" class="panel-collapse collapse"> <div class="panel-body">' + stopover_names_text + "<br>" + route_pros_cons_text + '<br>' + where_to_buy_text + '</div> </div> </div>');
    //     }
}

function fill_cart(product_names, product_ids, product_quantities, product_added_by_names, product_changed_by_names) {
    var cart_products = $('#cart_products');
    cart_products.empty();
    for (var i = 0; i < product_names.length; i++) {
        cart_products.append('<tr id="product_' + product_ids[i] + '"> <td class="cart_product"> <a href=""><img src="images/cart/one.png" alt=""></a> </td> <td class="cart_description"> <h4><a href="">' + product_names[i] + '</a></h4> <p>Web ID: ' + product_ids[i] + '</p> </td> <td class="cart_price"> <p>' + product_added_by_names[i] + '</p> </td> <td class="cart_quantity"> <div class="cart_quantity_button"> <a class="cart_quantity_up" href="javascript:inc_dec_quantity(' + product_ids[i] + ',1);"> + </a> <input onblur="change_quantity(' + product_ids[i] + ')" id="quantity_' + product_ids[i] + '" class="cart_quantity_input" type="text" name="quantity" value="' + product_quantities[i] + '" autocomplete="off" size="2"> <a class="cart_quantity_down" href="javascript:inc_dec_quantity(' + product_ids[i] + ',-1);"> - </a> </div> </td> <td class="cart_total"> <p id="changed_by_' + product_ids[i] + '" class="cart_total_price">' + product_changed_by_names[i] + '</p> </td> <td class="cart_delete"> <a class="cart_quantity_delete" href="javascript:remove_from_cart(' + product_ids[i] + ');"><i class="fa fa-times"></i></a> </td> </tr>');
    }

}

function inc_dec_quantity(product_id, change_amount) {
    $.ajax({
        type: "POST",
        data: {
            'post_inc_dec_quantity': 'post_inc_dec_quantity',
            'product_id': product_id,
            'change_amount': change_amount
        },
        success: function (data) {
            show_cart_notif(data['message'], 2000);
            var quantity = $('#quantity_' + product_id);
            quantity.val(parseInt(data['new_quantity']));
            var changed_by = $('#changed_by_' + product_id);
            changed_by.empty();
            changed_by.append(data['new_changed_by'])
        },
        error: function (xhr, ajaxOptions, thrownError) {
            var product_row = $('#product_' + product_id);
            product_row.remove();
            show_cart_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function change_quantity(product_id) {
    var quantity = $('#quantity_' + product_id);
    $.ajax({
        type: "POST",
        data: {
            'post_change_quantity': 'post_change_quantity',
            'product_id': product_id,
            'new_amount': quantity.val()
        },
        success: function (data) {
            show_cart_notif(data['message'], 2000);
            var changed_by = $('#changed_by_' + product_id);
            changed_by.empty();
            changed_by.append(data['new_changed_by'])
        },
        error: function (xhr, ajaxOptions, thrownError) {
            var product_row = $('#product_' + product_id);
            product_row.remove();
            show_cart_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function remove_from_cart(product_id) {
    $.ajax({
        type: "POST",
        data: {'post_remove_from_cart': 'post_remove_from_cart', 'product_id': product_id},
        success: function (data) {
            show_cart_notif(data['message'], 2000);
            var product_row = $('#product_' + product_id);
            product_row.remove();
        },
        error: function (xhr, ajaxOptions, thrownError) {
            var product_row = $('#product_' + product_id);
            product_row.remove();
            show_cart_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function fetch_route_defaults() {
    $.ajax({
        type: "POST",
        data: {'fetch_route_defaults': 'fetch_route_defaults'},
        success: function (data) {
            $('#opt_money').prop('checked', data['opt_money']);
            $('#opt_dist').prop('checked', data['opt_dist']);
            $('#opt_time').prop('checked', data['opt_time']);
            $('#tolerance').val(data['tolerance']);

            var start_point = $('#route_start_point');
            var end_point = $('#route_end_point');
            start_point.empty();
            end_point.empty();

            start_point.append('<option value="-1">- Select -</option>');
            end_point.append('<option value="-1">- Select -</option>');

            for (var i = 0; i < data['addresses'].length; i++) {
                start_point.append('<option value="' + data['addresses'][i]['address_id'] + '">' + data['addresses'][i]['address_name'] + '</option>')
                end_point.append('<option value="' + data['addresses'][i]['address_id'] + '">' + data['addresses'][i]['address_name'] + '</option>')
            }

            start_point.val(data['start_point_id']).change();
            end_point.val(data['end_point_id']).change();
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_cart_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function save_as_route_defaults(serialized_form) {
    serialized_form += "&save_as_route_defaults=save_as_route_defaults";
    $.ajax({
        type: "POST",
        data: serialized_form,
        success: function (data) {
            show_account_notif(data['message'], 2000);
            fetch_route_defaults();
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_account_notif(xhr['responseJSON']['message'], 2000);
            fetch_route_defaults();
        }
    });
}

function fetch_cart_data() {
    $.ajax({
        type: "POST",
        data: {'get_shopping_list_data': 'get_shopping_list_data'},
        success: function (data) {
            fill_cart(data['product_name'], data['product_id'], data['product_quantity'], data['product_added_by'], data['product_changed_by']);
            var active_list_text = $('#active_list_text');
            active_list_text.attr('data-list_id', data['active_list_id']);
            active_list_text.html(data['active_list_name'] + " ");
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_cart_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function show_cart_notif(msg, time) {
    var cart_notification = $('#cart_notification');
    cart_notification.attr('data-original-title', msg).tooltip("show");
    setTimeout(function () {
        $('#cart_notification').tooltip('hide');
    }, time);
}