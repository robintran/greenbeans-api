var g_auth_token;
var g_number_beans;

$(function(){
    $( document ).delegate("#homeBeans", "pageinit", function() {
        $('#home_bean_grid_view').html('');
        if(g_number_beans == -1) {
            g_number_beans = 9;
        }
        for (var i = 0; i < g_number_beans; i++) {
            if (i%5 == 0) {
                $('#home_bean_grid_view').append(
                  '<div class="ui-block-a"><img src="../resources/images/bean.png" width=59 class="bean"/></div>'
                );
            } else if (i%5 == 1) {
                $('#home_bean_grid_view').append(
                  '<div class="ui-block-b"><img src="../resources/images/bean.png" width=59 class="bean"/></div>'
                );
            } else if (i%5 == 2) {
                $('#home_bean_grid_view').append(
                  '<div class="ui-block-c"><img src="../resources/images/bean.png" width=59 class="bean"/></div>'
                );
            } else if (i%5 == 3) {
                $('#home_bean_grid_view').append(
                  '<div class="ui-block-d"><img src="../resources/images/bean.png" width=59 class="bean"/></div>'
                );
            } else {
                $('#home_bean_grid_view').append(
                  '<div class="ui-block-e"><img src="../resources/images/bean.png" width=59 class="bean"/></div>'
                );
            }
        }
        $("#homeBeans .number-of-beans").html('You have ' + g_number_beans + ' beans');
    });
})
function claimBeans (beanCode) {
    var params = {
        
    }
    $.mobile.showPageLoadingMsg();
    var url = 'http://107.20.196.96/api/consumer/beans/validate.json?code=' + beanCode;
    $.ajax({
        type: 'GET',
        dataType: 'json',
        url: url,
        timeout: 5000,
        withCredentials: true,
        useDefaultXhrHeader: false,
        success: function(response, textStatus ){
            $.mobile.hidePageLoadingMsg();
            if (response.status == 200) {
                g_number_beans = -1;
                $.mobile.changePage( "homeBeans.html", { transition: "slide"} );
            } else {
                $("#claimBeansErrorText").show("fast");
            }
        },
        error: function(response, textStatus, errorThrown){
            $.mobile.hidePageLoadingMsg();
            var result = jQuery.parseJSON(response.responseText);
            if (response.status == 401) {
                window.localStorage.removeItem("gb_auth_token");
            }
            $("#claimBeansErrorText").show("fast");
        }
    });
}

function signin (mail, pass) {
    var params = {
        "user[email]" : mail,
        "user[password]" : pass,
    }
    $.mobile.showPageLoadingMsg("b", "Logging in...", false);
    var url = 'http://107.20.196.96/api/consumer/sessions.json';
    $.ajax({
        type: 'POST',
        dataType: 'json',
        data: params,
        url: url,
        timeout: 5000,
        withCredentials: true,
        useDefaultXhrHeader: false,
        success: function(response, textStatus ){
            $.mobile.hidePageLoadingMsg();
            if (response.status == 200) {
                window.localStorage.setItem("gb_auth_token", response.user.auth_token);
                g_auth_token = response.user.auth_token;
                console.log(response.user.auth_token);
                loadMyBeans();
            } else {
                $("#loginFailDialog_msg").html(response.message);
                $("#loginFailDialog").popup('open', { transition: "pop"});
            }
        },
        error: function(xhr, textStatus, errorThrown){
            $.mobile.hidePageLoadingMsg();
            $("#loginFailDialog_msg").html("Login failure, please try again.");
            $("#loginFailDialog").popup('open', { transition: "pop"});
        }
    });
}

function loadMyBeans () {
    var params = {
    }
    $.mobile.showPageLoadingMsg();
    var url = 'http://107.20.196.96/api/consumer/beans/my_beans.json?auth_token=' + g_auth_token;
    $.ajax({
        type: 'GET',
        dataType: 'json',
        url: url,
        timeout: 5000,
        withCredentials: true,
        useDefaultXhrHeader: false,
        success: function(response, textStatus ){
            $.mobile.hidePageLoadingMsg();
            if (response.status == 200) {
                g_number_beans = response.active_beans.size;
                $.mobile.changePage( "homeBeans.html", { transition: "slide"} );
            } else {
                $("#getMyBeansFailDialog_msg").html(response.message);
                $("#getMyBeansFailDialog").popup('open', { transition: "pop"});
            }
        },
        error: function(response, textStatus, errorThrown){
            $.mobile.hidePageLoadingMsg();
            var result = jQuery.parseJSON(response.responseText);
            if (response.status == 401) {
                window.localStorage.removeItem("gb_auth_token");
                $("#getMyBeansFailDialog_msg").html(result.error);
                $("#getMyBeansFailDialog").popup('open', { transition: "pop"});
            };
        }
    });
}

function getMyBeans() {
    var auth_token = window.localStorage.getItem("gb_auth_token");
    if (auth_token && auth_token.length > 0) {
        g_auth_token = auth_token;
        loadMyBeans();
    } else {
        $.mobile.changePage( "signup.html", { transition: "slide"} );
    }
}

function onLogoutBtnTap() {
    var params = {
        "auth_token" : g_auth_token,
    }
    $.mobile.showPageLoadingMsg("b", "Logout...", false);
    var url = 'http://107.20.196.96/api/consumer/sessions/delete.json';
    $.post(url,
        params, function(response) {
            $.mobile.hidePageLoadingMsg();
            if (response.status == 200) {
                $.mobile.changePage( "claimBeans.html", { transition: "slide", reverse: true} );
            } else {
                $.mobile.changePage( "claimBeans.html", { transition: "slide", reverse: true} );
            }
        }
    )
}