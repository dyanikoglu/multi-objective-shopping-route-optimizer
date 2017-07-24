/**
 * Created by dyanikoglu on 22.03.2017.
 */
var map;
var directionsDisplay;
var directionsService;
var infoWindow;

// function createInfoWindow(marker, popupContent) {
//     google.maps.event.addListener(marker, 'click', function () {
//         infoWindow.setContent(popupContent);
//         infoWindow.open(map, this);
//     });
// }

function initMap() { // Creates a dummy map in map modal
    map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: -34.397, lng: 150.644},
        zoom: 8
    });
    directionsService = new google.maps.DirectionsService;
    directionsDisplay = new google.maps.DirectionsRenderer;
    directionsDisplay.setMap(map);
}

/*
    Fills down-side panel of google maps modal with directives
    route_index: Selected route index of "route_data" object
    stopover_order: Real ordering of stopover points in calculated route
 */
function fillRouteDirectives(stopover_order, route_index) {
    var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("");
    var right_panel = $('#route_panel');
    var stopover_count = route_data[route_index]['stopover_names'].length;

    right_panel.empty(); // Reset panel data
    right_panel.append("<h2 style='color: orange'>&nbsp;Route Overview&nbsp;&nbsp;</h2>");
    right_panel.append('<span><img style="width: 2em; height: 2em;" src="http://housing.utk.edu/wp-content/uploads/sites/12/2016/10/Tour2.png"></span>' + route_data[route_index]['stopover_names'][0]);
    right_panel.append('<span style="color: orange; font-weight: bold">&nbsp;&nbsp;· · ·&nbsp;</span>');
    // Show retailers to visit with fancy marker icons
    for (var j = 0; j < route_data[route_index]['stopover_names'].length - 2; j++) {
        right_panel.append('<span><img style="width: 2em; height: 2em;" src="http://housing.utk.edu/wp-content/uploads/sites/12/2016/10/Tour2.png"></span>' + route_data[route_index]['stopover_names'][stopover_order[j] + 1]);
        right_panel.append('<span style="color: orange; font-weight: bold">&nbsp;&nbsp;· · ·&nbsp;</span>');
    }
    right_panel.append('<span><img style="width: 2em; height: 2em;" src="http://housing.utk.edu/wp-content/uploads/sites/12/2016/10/Tour2.png"></span>' + route_data[route_index]['stopover_names'][stopover_count-1]);


    // Build full shopping guide
    right_panel.append("<h2 style='color: orange'>&nbsp;Shopping Guide&nbsp;&nbsp;</h2>");

    for (i = 0; i < stopover_count - 2; i++) {
        right_panel.append('<span><img style="width: 2em; height: 2em;" src="http://housing.utk.edu/wp-content/uploads/sites/12/2016/10/Tour2.png"></span>' + route_data[route_index]['stopover_names'][stopover_order[i] + 1] + '<br>');

        // Print products of this retailer
        for (j = 0; j < route_data[route_index]['product_names'].length; j++) {
            if (route_data[route_index]['retailer_names'][j] === route_data[route_index]['stopover_names'][stopover_order[i] + 1]) {
                right_panel.append(route_data[route_index]['product_names'][j] + '<br>');
            }
        }
        right_panel.append('<br><div class="choose"></div><br>');
    }

    right_panel.append('<button onclick="complete_shopping_list(); return false;">Complete Shopping</button><br><br>');
}

function complete_shopping_list() {
    $.ajax({
        type: "POST",
        data: {'complete_shopping_list': 'complete_shopping_list'},
        success: function (data) {
            location.reload();
        },
        error: function (xhr, ajaxOptions, thrownError) {
            show_cart_notif(xhr['responseJSON']['message'], 2000);
        }
    });
}

function calcRoute(coordinates, route_index) {
    var start = new google.maps.LatLng(coordinates[0][1], coordinates[0][0]);
    var end = new google.maps.LatLng(coordinates[coordinates.length - 1][1], coordinates[coordinates.length - 1][0]);
    var waypoints = [];

    for (var i = 1; i < coordinates.length - 1; i++) {
        var coord = new google.maps.LatLng(coordinates[i][1], coordinates[i][0])
        waypoints.push({
            location: coord,
            stopover: true
        });
    }

    var request = {
        origin: start,
        destination: end,
        optimizeWaypoints: true,
        waypoints: waypoints,
        travelMode: 'DRIVING'
    };

    directionsService.route(request, function (result, status) { // Triggered when request is answered, not synced with code
        if (status === 'OK') {
            directionsDisplay.setDirections(result);
            fillRouteDirectives(result['routes'][0]['waypoint_order'], route_index);
        }
    });
}

function initialize_route_view(route_index) {
    $('#route_panel_extender').show();
    $('#route_selection').hide();
    $('#route_view').show();
    var back_button = $('#back_button');
    back_button.show();
    back_button.click(function () {
        $('#route_selection').show();
        $('#route_view').hide();
        $('#route_panel_extender').hide();
        $('#route_panel').hide();
        back_button.hide();
    });

    google.maps.event.trigger(map, 'resize');
    map.setCenter(new google.maps.LatLng(route_data[route_index]['stopover_coords'][0][1], route_data[route_index]['stopover_coords'][0][0]));
    console.log(route_data[route_index]);

    var coordinates = route_data[route_index]['stopover_coords'];
    var stopover_names = route_data[route_index]['stopover_names'];

    // for (var i = 0; i < coordinates.length; i++) {
    //     position = new google.maps.LatLng(route_data[route_index]['stopover_coords'][i][1], route_data[route_index]['stopover_coords'][i][0]);
    //     var marker = new google.maps.Marker({
    //         position: position,
    //         map: map,
    //         animation: google.maps.Animation.DROP,
    //         title: "asdasdasd"
    //     });
    //     var popupContent = "asdasdasdas";
    //     createInfoWindow(marker, popupContent);
    // }

    directionsDisplay.setMap(map);
    // directionsDisplay.setPanel(document.getElementById('route_panel')); // Add route directions into div element
    calcRoute(route_data[route_index]['stopover_coords'], route_index);
}