/**
 * Created by dyanikoglu on 10.05.2017.
 */

function login() {
    var url = "/gisModule/login/"; // the script where you handle the form input.
    var post_data = JSON.parse(JSON.stringify($("#login_form").serialize())); // serializes the form's elements.
    post_data += "&login=login";
    $.ajax({
        type: "POST",
        url: url,
        data: post_data,
        success: function (data) {
            window.location.href = data.url;
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(xhr.status + ' Error: ' + xhr.responseJSON['message']);
        }
    });
}

function register() {
    var url = "/gisModule/login/"; // the script where you handle the form input.
    var post_data = JSON.parse(JSON.stringify($("#register_form").serialize())); // serializes the form's elements.
    post_data += "&register=register";
    $.ajax({
        type: "POST",
        url: url,
        data: post_data,
        success: function (data) {
            window.location.href = data.url;
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(xhr.status + ' Error: ' + xhr.responseJSON['message']);
        }
    });
}