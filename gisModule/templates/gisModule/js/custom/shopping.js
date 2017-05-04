function isArray(o) {
    return Object.prototype.toString.call(o) === '[object Array]';
}

var i = 0;
var j = 0;

/* Traversal For Product Tree */
function traverseProductTree(x, level) {
    if (isArray(x)) {
        x.forEach(function (x) {
            var key = Object.keys(x)[0]
            document.getElementById("id_listRow" + j).innerHTML += '<tr class="c_itemRow"><td>' + key + '</td><td><input type="submit" id="id_addToCartButton" name="submit" value="Add to cart" onclick="simpleCart.add({itemid:\'' + x[key] + '\', addedby:\'' + user_obj.username + '\', name:\'' + key + '\'});simpleCart.update();" style="float: right"/></td></tr>';
        });
    } else if ((typeof x === 'object') && (x !== null)) {
        traverseProductTreeObject(x, level);
    }
}

function traverseProductTreeObject(obj, level) {
    for (var key in obj) {
        if (obj.hasOwnProperty(key)) {
            if (level === 0) {
                i++;
                document.getElementById("id_productTree").innerHTML += '<div class="panel panel-primary" style="margin-left: 1%;margin-right: 1%"> <div class="panel-heading"> <h4 class="panel-title"> <a data-toggle="collapse" data-parent="#accordion" href="#collapse_product_category_' + i + '">' + key + '</a> </h4> </div> <div id="collapse_product_category_' + i + '" class="panel-collapse collapse"> <div class="panel-body">' + '<table id="id_mainCategoryTable' + i + '" class="table table-condensed"></table>' + '</div> </div> </div>';
            }
            else if (level === 1) {
                j++;
                document.getElementById("id_mainCategoryTable" + i).innerHTML += '<thead id="id_subCategoryHeader"><tr><th>' + key + '</th></tr></thead><tbody id="id_listRow' + j + '"></tbody>';

            }
            else {
                j++;
                document.getElementById("id_mainCategoryTable" + i).innerHTML += '<thead id="id_subSubCategoryHeader"><tr><th>' + key + '</th></tr></thead><tbody id="id_listRow' + j + '"></tbody>';
            }
            traverseProductTree(obj[key], level + 1);
        }
    }
}

/* Traversal For User Shopping List Names */
function traverseShoppingLists(x) {
    for (var key in x) {
        document.getElementById("id_shoppingCartList").innerHTML += '<a href=\"javascript:changeCart(' + x[key] + ');\">' + key + '</a>'
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

// Sets user preferences that came as JSON objects
function fetchUserPreferences(dist_cost, money_cost, time_cost, search_radius, address_names, address_coords, start_point_name, end_point_name) {
    $('#id_dist_factor').prop('checked', false);
    $('#id_money_factor').prop('checked', false);
    $('#id_time_factor').prop('checked', false);
    $('#id_search_radius').prop('value', search_radius);

    if (dist_cost === 'True') {
        $('#id_dist_factor').prop('checked', true);
    }
    if (money_cost === 'True') {
        $('#id_money_factor').prop('checked', true);
    }
    if (time_cost === 'True') {
        $('#id_time_factor').prop('checked', true);
    }
    var i = 0;
    for(i;i<address_names.length;i++) {
        $('#id_start_point').append('<option value="' + address_coords[i] + '">' + address_names[i] + '</option>');
        $('#id_end_point').append('<option value="' + address_coords[i] + '">' + address_names[i] + '</option>');
    }

    var start_point_select = document.getElementById('id_start_point')
    for (var i = 0; i < start_point_select.options.length; ++i) {
        if (start_point_select.options[i].text === start_point_name)
            start_point_select.options[i].selected = true;
    }

    var end_point_select = document.getElementById('id_end_point')
    for (var i = 0; i < end_point_select.options.length; ++i) {
        if (end_point_select.options[i].text === end_point_name)
            end_point_select.options[i].selected = true;
    }
}