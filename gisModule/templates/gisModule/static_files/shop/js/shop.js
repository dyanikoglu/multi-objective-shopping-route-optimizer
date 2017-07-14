function isArray(o) {
    return Object.prototype.toString.call(o) === '[object Array]';
}

/* Traversal For Product Tree */
function traverseProductTree(obj, ids, level, latestID) {
    if ((typeof obj === 'object') && (obj !== null)) {
        for (var key in obj) {
            if (obj.hasOwnProperty(key)) {
                var transformed_key = key.replace(/ /g, '_').replace(/&/g, '_');
                if (level === 0) {
                    $('#categories').append('<div class="panel panel-default"> <div class="panel-heading"> <h4 class="panel-title"> <a data-toggle="collapse" data-parent="#categories" href="#' + transformed_key + '"><span class="badge pull-right"><i class="fa fa-plus"></i></span></a><a href="javascript:load_products(' + ids[key] + ');">' + key + '</a></h4> </div> <div id="' + transformed_key + '" class="panel-collapse collapse"> <div id="' + transformed_key + '_panel" class="panel-body"></div> </div></div>');
                }
                else {
                    var transformed_id = latestID.replace(/ /g, '_').replace(/&/g, '_');
                    $('#' + transformed_id + '_panel').append('<div class="panel panel-primary"> <div class="panel-heading"> <h4 class="panel-title"> <a data-toggle="collapse" data-parent="#' + transformed_id + '_panel" href="#' + transformed_key + '"> <span class="badge pull-right"><i class="fa fa-plus"></i></span></a><a href="javascript:load_products(' + ids[key] + ');">' + key + '</a></h4> </div> <div id="' + transformed_key + '" class="panel-collapse collapse"><div id="' + transformed_key + '_panel" class="panel-body"></div> </div></div>');
                }
                traverseProductTree(obj[key], ids, level + 1, key);
            }
        }
    }
}

// Adds given product to user's active shopping cart
function add_to_cart(product_id) {
    $.ajax({
        type: "POST",
        data: {"post_add_to_cart": "post_add_to_cart", 'product_id': product_id},
        success: function (data) {
            show_cart_notif(data['message'], 2000);
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_cart_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function search_product(search_text) {
    if (!search_text) {
        active_category_id = -1;
        var category_products = $('#category_products');
        category_products.hide();
        category_products.empty();
        return;
    }

    $.ajax({
        type: "POST",
        data: {"post_search_product": "post_search_product", 'search_text': search_text},
        success: function (data) {
            active_category_id = -1;
            var obj = data['loaded_products'];
            var category_products = $('#category_products');
            category_products.hide();
            category_products.empty();
            if ((typeof obj === 'object') && (obj !== null)) {
                for (var key in obj) {
                    if (obj.hasOwnProperty(key)) {
                        show_product(key, obj[key], category_products);
                    }
                }
            }
            category_products.show('normal');
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_cart_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

// Shows a product in shopping page
function show_product(product_name, product_id, product_list_div) {
    product_list_div.append('<div class="col-sm-4"> <div class="product-image-wrapper"> <div class="single-products"> <div class="productinfo text-center"> <img src="' + STATIC_URL + 'shop/img/product.png" alt="" /> <h2></h2> <p>' + product_name + '</p> </div> <div class="product-overlay"> <div class="overlay-content"> <h2>' + product_name + '</h2><a href="javascript:add_to_cart(' + product_id + ')" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a> </div> </div> </div> <div class="choose"> <ul class="nav nav-pills nav-justified"> <li><a onclick="fetch_product_details(' + product_id + ')"><i class="fa fa-plus-square"></i>Product Details</a></li> </ul> </div> </div> </div>');
}

// Loads products from selected category into shopping page
var active_category_id = -1;

function load_products(category_id) {
    if (category_id === active_category_id) // Active category selected again, do not send ajax request
        return;
    $('#category_products').show('normal');
    $('#product_details').hide('normal');
    $.ajax({
        type: "POST",
        data: {"post_load_products": "post_load_products", "category_id": category_id},
        success: function (data) {
            active_category_id = parseInt(data['category_id']);
            var obj = data['loaded_products'];
            var category_products = $('#category_products');
            category_products.hide();
            category_products.empty();
            if ((typeof obj === 'object') && (obj !== null)) {
                for (var key in obj) {
                    if (obj.hasOwnProperty(key)) {
                        show_product(key, obj[key], category_products);
                    }
                }
            }
            category_products.show('normal');
        },
        error: function (jXHR, textStatus, errorThrown) {
            alert(errorThrown);
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

function clear_product_details() {
    $('#product_name').empty();
    $('#product_id').empty();
}

function blame(retailer_product_id) {
    var response = confirm("You're about to blame this retailer for a false price. Continue?");
    if (response === true) {
        $.ajax({
            type: "POST",
            data: {"blame_retailer": "blame_retailer", "retailer_product_id": retailer_product_id},
            success: function (data) {
                show_account_notif(data['message'], 2000);
            },
            error: function (jXHR, textStatus, errorThrown) {
                alert(errorThrown);
            }
        });
    }
}

function fetch_product_details(product_id) {
    clear_product_details();
    $('#product_details').show('normal');
    $('#category_products').hide('normal');
    var add_to_cart_button = $('#details_add_to_cart_button');
    $.ajax({
        type: "POST",
        data: {"fetch_product_details": "fetch_product_details", "product_id": product_id},
        success: function (data) {
            $('#product_name').append(data['product_name']);
            $('#product_id').append("Web ID: " + data['product_id']);
            add_to_cart_button.removeAttr("onClick");
            add_to_cart_button.attr("onClick", "add_to_cart(" + product_id + "); return false;");
            var all_prices_table = $('#all_prices');
            all_prices_table.empty();
            // Fill prices for each retailer
            for (var i = 0; i < data['retailer_prices'].length; i++) {
                all_prices_table.append('<tr> <td>' + data['retailer_prices'][i]['retailer_name'] + '</td><td>' + data['retailer_prices'][i]['retailer_price'] + '</td><td><button onClick="blame(' + data['retailer_prices'][i]['retailer_product_id'] + '); return false;" class="btn btn-warning">···</button></td></tr><tr class="blame_form" id="ret_prod_' + data['retailer_prices'][i]['retailer_product_id'] + '"></tr>');
            }
        },
        error: function (jXHR, textStatus, errorThrown) {
            alert(errorThrown);
        }
    });
}