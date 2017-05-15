/**
 * Created by dyanikoglu on 10.05.2017.
 */

$(document).ready(function () {
    fetch_cart_data();
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
                    data: {'change_active_list': 'change_active_list', 'list_id': $('#active_list_selection').find(':selected').val()},
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
                            if(data['active_list_id'] === data['lists'][i]['list_id']) {
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
        data: {'post_change_quantity': 'post_change_quantity', 'product_id': product_id, 'new_amount': quantity.val()},
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