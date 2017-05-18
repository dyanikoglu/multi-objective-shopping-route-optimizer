/**
 * Created by dyanikoglu on 10.05.2017.
 */

$(document).ready(function () {
    fetch_cart_data();
    fetch_route_defaults();

    $('#show_more_routes_button').click(function () {
        $('#other_routes').toggle('fast');
        var ico = $('#show_more_routes_icon');
        if (ico.attr('class') === 'fa fa-arrow-up') {
            ico.attr('class', 'fa fa-arrow-down');
        } else {
            ico.attr('class', 'fa fa-arrow-up');
        }
        return false;
    });

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
        var main;

        // Put the route to other routes section
        if (i !== m_champ_ind && i !== d_champ_ind && i !== t_champ_ind && i !== r_champ_ind) {
            other_routes.append('<div id="route_main_' + i + '"></div>');
            main = $('#route_main_' + i);
            main.append('<br><h2 style="color: orange">Other Route - ' + route_indexing++ + '</h2>');
            other_routes.append('<div id="route_details_' + i + '"></div>');
        }
        // Put the route to champion routes section
        else {
            champ_routes.append('<div id="route_main_' + i + '"></div>');
            main = $('#route_main_' + i);
            var title_text = "";
            if (i === r_champ_ind) {
                title_text = "Best Route";
            } else {
                if (i === m_champ_ind) {
                    title_text += "Money, "
                } else if (i === d_champ_ind) {
                    title_text += "Distance, "
                } else if (i === t_champ_ind) {
                    title_text += "Time, "
                }
                title_text = title_text.replace(/,([^,]*)$/, '' + '$1'); // Remove latest comma
                title_text += 'Optimized Route'
            }
            main.append('<br><h2 style="color: orange">' + title_text + '</h2>');
            champ_routes.append('<div id="route_details_' + i + '"></div>');
        }

        var details = $('#route_details_' + i);
        details.append('<div class="row" id="route_details_retailers_' + i + '"></div>')
        var retailers = $('#route_details_retailers_' + i);

        // Show retailers to visit
        for (var j = 1; j < current_route['stopover_names'].length - 1; j++) {
            retailers.append('<span><img style="width: 2em; height: 2em;" src="http://housing.utk.edu/wp-content/uploads/sites/12/2016/10/Tour2.png"></span>' + current_route['stopover_names'][j]);
            if (j !== current_route['stopover_names'].length - 2) {
                retailers.append('<span style="color: orange; font-weight: bold">&nbsp;&nbsp;· · ·&nbsp;</span>');
            }
        }

        var time_value = current_route['costs'][2] * 60;
        var hours = parseInt(time_value / 60);
        var minutes = parseInt(time_value % 60);
        retailers.append('<div style="margin-top: 25px" class="row"><span><img style="width: 2em; height: 2em;" src="https://i.hizliresim.com/LyrOqj.png"></span>&nbsp;' + current_route['costs'][0] + '&nbsp;TL&nbsp;&nbsp;&nbsp;&nbsp; <img style="width: 2em; height: 2em;" src="https://image.flaticon.com/icons/png/128/31/31126.png"></span>&nbsp;' + current_route['costs'][1].toFixed(2) + '&nbsp;KM&nbsp;&nbsp;&nbsp;&nbsp;<span><img style="width: 2em; height: 2em;" src="http://wcdn3.dataknet.com/static/resources/icons/set110/f112ae8c.png"></span>&nbsp;' + hours + 'h&nbsp;' + minutes + 'm</div>');


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
                retailers.append('<div class="row"><p>You will spend <b>' + parseInt(current_route['money_diff']) + ' TL</b> more than money optimized route</p></div>');
            }

            if (!is_dist_optimized) {
                retailers.append('<div class="row"><p>You will travel <b>' + parseInt(current_route['dist_diff']) + ' km</b> more than distance optimized route</p></div>');
            }

            if (!is_time_optimized) {
                var hour_text = "You will shop <b>";
                if (hours !== 0) {
                    hour_text += hours + "h ";
                }
                if (minutes !== 0) {
                    hour_text += minutes + "min ";
                }
                hour_text += "</b>more than time optimized route";
                retailers.append('<div class="row"><p>' + hour_text + '</p></div>');
            }

            var show_prices_id = '#product_prices_' + i;
            details.append('<ul class="nav nav-pills nav-justified"><li><a onclick="$(\'' + show_prices_id + '\').toggle(\'normal\'); return false;" href="#" style="color: orange"><i class="fa fa-plus-square"></i> See Product Prices</a></li></ul>');
            details.append('<div id="product_prices_' + i + '" hidden></div>');

            var product_prices = $('#product_prices_' + i);

            ///// Initialize Buy Which Product From Where
            var where_to_buy_text = "";
            var items_to_buy_from_retailers = [];
            where_to_buy_text = '<div class="datagrid"><table><thead> <tr><th>Retailer Name/ Product Info<br></th> <th>Product Name<br></th> <th>Unit Price</th> <th>Count</th> <th>Total Price</th> </tr> </thead>';
            var k = 0;
            var unique_retailers = current_route['retailer_names'].filter(onlyUnique);
            var retailer_products = [];
            var l = 0;
            for (k; k < unique_retailers.length; k++) {
                retailer_products = [];
                var temp_product_names = [];
                var retailer_product_prices = [];
                l = 0;
                for (l; l < current_route['retailer_names'].length; l++) {
                    if (current_route['retailer_names'][l] === unique_retailers[k]) {
                        retailer_products.push(current_route['product_names'][l]);
                        retailer_product_prices.push(current_route['product_prices'][l]);
                    }
                }

                temp_product_names.push(retailer_products); // This is required for right panel of map modal

                where_to_buy_text += '<tbody><tr><td rowspan="' + retailer_products.length + '">' + unique_retailers[k] + '<br></td>';
                where_to_buy_text += '<td>' + retailer_products[0] + '<br></td> <td>' + retailer_product_prices[0] + 'TL' + '</td> <td>' + current_route['product_quantities'][0] + '</td> <td>' + current_route['product_quantities'][0] * retailer_product_prices[0] + 'TL' + '</td> </tr>';

                l = 1;
                for (l; l < retailer_products.length; l++) {
                    where_to_buy_text += '<tr> <td>' + retailer_products[l] + '</td> <td>' + retailer_product_prices[l] + 'TL' + '</td> <td>' + current_route['product_quantities'][l] + '</td> <td>' + current_route['product_quantities'][l] * retailer_product_prices[l] + 'TL' + '</td> </tr>'
                }
            }

            items_to_buy_from_retailers.push(temp_product_names);
            where_to_buy_text += '</tbody></table></div>';
            product_prices.append(where_to_buy_text);
            ///////////////

            details.append('<br><div class="choose"></div>');
        }
    }
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

function onlyUnique(value, index, self) {
    return self.indexOf(value) === index;
}