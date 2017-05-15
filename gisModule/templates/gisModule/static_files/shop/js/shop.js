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

/* Traversal For User Shopping List Names */
function traverseShoppingLists(x) {
    for (var key in x) {
        if (x.hasOwnProperty(key)) {
            document.getElementById("id_shoppingCartList").innerHTML += '<a href=\"javascript:changeCart(' + x[key] + ');\">' + key + '</a>'
        }
    }
}

/* Traversal For User Shopping List Product Data */
var shopping_list_id, shopping_list_name;
function traverseShoppingListData(x, level) {
    if (isArray(x)) {
        traverseShoppingListDataArray(x, level);
    } else if ((typeof x === 'object') && (x !== null)) {
        traverseShoppingListDataObject(x, level);
    } else {
    }
}
function traverseShoppingListDataArray(arr, level) {
    arr.forEach(function (x) {
        traverseShoppingListData(x, level);
    });
}
function traverseShoppingListDataObject(obj, level) {
    if (level !== 0) {
        simpleCart.add({itemid: obj.item_id, addedby: obj.added_by, name: obj.name, quantity: obj.quantity}, true)
    }
    for (var key in obj) {
        if (obj.hasOwnProperty(key)) {
            if (key === "ListID") {
                shopping_list_id = obj[key];
            }
            if (key === "ListName") {
                shopping_list_name = obj[key];
            }
            if (key === "ListProducts") {
                traverseShoppingListData(obj[key], level + 1);
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
    product_list_div.append('<div class="col-sm-4"> <div class="product-image-wrapper"> <div class="single-products"> <div class="productinfo text-center"> <img src="' + STATIC_URL + 'shop/img/product.png" alt="" /> <h2></h2> <p>' + product_name + '</p> </div> <div class="product-overlay"> <div class="overlay-content"> <h2>Lowest Price: 0TL</h2> <h2>Highest Price: 0TL</h2> <h2>Average Price: 0TL</h2> <p>' + product_name + '</p> <a href="javascript:add_to_cart(' + product_id + ')" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a> </div> </div> </div> <div class="choose"> <ul class="nav nav-pills nav-justified"> <li><a href=""><i class="fa fa-plus-square"></i>See All Prices</a></li> </ul> </div> </div> </div>');
}

// Loads products from selected category into shopping page
var active_category_id = -1;
function load_products(category_id) {
    if (category_id === active_category_id) // Active category selected again, do not send ajax request
        return;
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

// Sets user preferences that came as JSON objects
function fetchUserPreferences(dist_cost, money_cost, time_cost, search_radius, address_names, address_coords, start_point_name, end_point_name) {
    var dist_factor = $('#id_dist_factor');
    var money_factor = $('#id_money_factor');
    var time_factor = $('#id_time_factor');
    dist_factor.prop('checked', false);
    money_factor.prop('checked', false);
    time_factor.prop('checked', false);
    $('#id_search_radius').prop('value', search_radius);

    if (dist_cost === 'True') {
        dist_factor.prop('checked', true);
    }
    if (money_cost === 'True') {
        money_factor.prop('checked', true);
    }
    if (time_cost === 'True') {
        time_factor.prop('checked', true);
    }
    var i;
    for (i = 0; i < address_names.length; i++) {
        $('#id_start_point').append('<option value="' + address_coords[i] + '">' + address_names[i] + '</option>');
        $('#id_end_point').append('<option value="' + address_coords[i] + '">' + address_names[i] + '</option>');
    }

    var start_point_select = document.getElementById('id_start_point');
    for (i = 0; i < start_point_select.options.length; ++i) {
        if (start_point_select.options[i].text === start_point_name)
            start_point_select.options[i].selected = true;
    }

    var end_point_select = document.getElementById('id_end_point');
    for (i = 0; i < end_point_select.options.length; ++i) {
        if (end_point_select.options[i].text === end_point_name)
            end_point_select.options[i].selected = true;
    }
}

function show_cart_notif(msg, time) {
    var cart_notification = $('#cart_notification');
    cart_notification.attr('data-original-title', msg).tooltip("show");
    setTimeout(function () {
        $('#cart_notification').tooltip('hide');
    }, time);
}