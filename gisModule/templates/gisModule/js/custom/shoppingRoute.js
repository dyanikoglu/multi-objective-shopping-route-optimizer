/**
 * Created by dyanikoglu on 22.03.2017.
 */
var map;
var directionsDisplay;
var directionsService = new google.maps.DirectionsService();
var infoWindow = new google.maps.InfoWindow();

function createInfoWindow(marker, popupContent) {
    google.maps.event.addListener(marker, 'click', function () {
        infoWindow.setContent(popupContent);
        infoWindow.open(map, this);
    });
}

function dummyMap() { // Creates a dummy map in map modal
    var mapOptions = {
        center: new google.maps.LatLng(17.377631, 78.478603),
        zoom: 9,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    map = new google.maps.Map(document.getElementById("gMaps"), mapOptions);
    google.maps.event.trigger(window, 'resize', {})
}

/*
    Fills right-side panel of google maps modal with directives
    selected_index: Selected route index of "all_route_data" variable
    stopover_order: Real ordering of stopover points in calculated route
 */
function fillRouteDirectives(selected_index, stopover_order) {
    console.log(this.items_to_buy_from_retailers);
    var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("");
    var right_panel = $('#right-panel');
    var stopover_count = this.all_route_data['stopover_names'][selected_index].length;
    right_panel.empty();
    right_panel.append("A: Start your trip from \"" + this.all_route_data['stopover_names'][selected_index][0] + "\"<br><br>");

    console.log(this.items_to_buy_from_retailers);
    console.log(selected_index);

    for(i=0;i<stopover_count-2;i++) {
        right_panel.append(alphabet[i+1] + ": Continue your trip with \"" + this.all_route_data['stopover_names'][selected_index][stopover_order[i]+1] + "\"<br>");
        right_panel.append("Buy these products: ");

        for(j=0;j<this.items_to_buy_from_retailers[selected_index][stopover_order[i]].length;j++) {
            right_panel.append(this.items_to_buy_from_retailers[selected_index][stopover_order[i]][j] + ', ');
        }
        right_panel.append("<br><br>");
    }

    right_panel.append(alphabet[stopover_count - 1] + ": End your trip at \"" + this.all_route_data['stopover_names'][selected_index][stopover_count - 1] + "\"<br>");
}

function calcRoute(coordinates, selected_route) {
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
        var selected_ind = selected_route;
        // console.log(result['routes'][0]['waypoint_order']); // Visiting order of retailers
        if (status == 'OK') {
            directionsDisplay.setDirections(result);
            fillRouteDirectives(selected_ind, result['routes'][0]['waypoint_order']);
        }
    });
}

function loadMap(data, selected_route) {
    var coordinates = data['route_coords'][selected_route];
    var stopover_names = data['stopover_names'][selected_route];

    var mapOptions = {
        center: new google.maps.LatLng(coordinates[0][1], coordinates[0][0]),
        zoom: 9,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    directionsDisplay = new google.maps.DirectionsRenderer();
    map = new google.maps.Map(document.getElementById("gMaps"), mapOptions);
    // for (var i = 0; i < coordinates.length; i++) {
    //     position = new google.maps.LatLng(coordinates[i][1], coordinates[i][0]);
    //     var marker = new google.maps.Marker({
    //         position: position,
    //         map: map,
    //         animation: google.maps.Animation.DROP,
    //         title: names[i]
    //     });
    //     var popupContent = names[i];
    //     createInfoWindow(marker, popupContent);
    // }
    directionsDisplay.setMap(map);
    // directionsDisplay.setPanel(document.getElementById('right-panel'));
    calcRoute(coordinates, selected_route);
    google.maps.event.trigger(window, 'resize', {});
}