/**
 * Created by dyanikoglu on 10.05.2017.
 */

function fill_cart(product_names, product_ids, product_quantities, product_added_by_names, product_changed_by_names) {
    var cart_products = $('#cart_products');

    for(var i=0;i<product_names.length;i++) {
        cart_products.append('<tr id="product_' + product_ids[i] + '"> <td class="cart_product"> <a href=""><img src="images/cart/one.png" alt=""></a> </td> <td class="cart_description"> <h4><a href="">' + product_names[i] + '</a></h4> <p>Web ID: ' + product_ids[i] + '</p> </td> <td class="cart_price"> <p>' + product_added_by_names[i] + '</p> </td> <td class="cart_quantity"> <div class="cart_quantity_button"> <a class="cart_quantity_up" href="javascript:inc_dec_quantity(' + product_ids[i] + ',1);"> + </a> <input onblur="change_quantity(' + product_ids[i] + ')" id="quantity_' + product_ids[i] + '" class="cart_quantity_input" type="text" name="quantity" value="' + product_quantities[i] + '" autocomplete="off" size="2"> <a class="cart_quantity_down" href="javascript:inc_dec_quantity(' + product_ids[i] + ',-1);"> - </a> </div> </td> <td class="cart_total"> <p id="changed_by_' + product_ids[i] + '" class="cart_total_price">' + product_changed_by_names[i] + '</p> </td> <td class="cart_delete"> <a class="cart_quantity_delete" href="javascript:remove_from_cart(' + product_ids[i] + ');"><i class="fa fa-times"></i></a> </td> </tr>');
    }

}

function inc_dec_quantity(product_id, change_amount) {
    $.ajax({
        type: "POST",
        data: {'post_inc_dec_quantity': 'post_inc_dec_quantity', 'product_id': product_id, 'change_amount': change_amount},
        success: function (data) {
            var quantity = $('#quantity_'+product_id);
            quantity.val(parseInt(data['new_quantity']));
            var changed_by = $('#changed_by_'+product_id);
            changed_by.empty();
            changed_by.append(data['new_changed_by'])
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(xhr.status + ' Error: ' + xhr.responseJSON['message']);
        }
    });
}

function change_quantity(product_id) {
    var quantity = $('#quantity_'+product_id);
    $.ajax({
        type: "POST",
        data: {'post_change_quantity': 'post_change_quantity', 'product_id': product_id, 'new_amount': quantity.val()},
        success: function (data) {
            var changed_by = $('#changed_by_'+product_id);
            changed_by.empty();
            changed_by.append(data['new_changed_by'])
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(xhr.status + ' Error: ' + xhr.responseJSON['message']);
        }
    });
}

function remove_from_cart(product_id) {
    $.ajax({
        type: "POST",
        data: {'post_remove_from_cart': 'post_remove_from_cart', 'product_id': product_id},
        success: function (data) {
            var product_row = $('#product_'+product_id);
            product_row.remove();
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(xhr.status + ' Error: ' + xhr.responseJSON['message']);
        }
    });
}

function fetch_cart_data() {
    $.ajax({
        type: "POST",
        data: {'get_shopping_list_data': 'get_shopping_list_data'},
        success: function (data) {
            fill_cart(data['product_name'], data['product_id'], data['product_quantity'], data['product_added_by'], data['product_changed_by']);
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(xhr.status + ' Error: ' + xhr.responseJSON['message']);
        }
    });
}