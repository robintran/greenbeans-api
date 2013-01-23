var gb_auth_token;
function claimBeans (beanCode) {
    var params = {
        
    }
    $.mobile.showPageLoadingMsg();
    var url = 'http://107.20.196.96/api/consumer/beans/validate.json?code=' + beanCode;
    $.get(url,
        params, function(response) {
            $.mobile.hidePageLoadingMsg();
            if (response.valid) {
                $.mobile.changePage( "homeBeans.html", { transition: "slide"} );
            } else {
                $("#claimBeansErrorText").show("fast");
            }
        }
    )
}

function signin (mail, pass) {
    var params = {
        "merchant[email]" : mail,
        "merchant[password]" : pass,
    }
    $.mobile.showPageLoadingMsg();
    var url = 'http://107.20.196.96/api/merchant/sessions.json';
    $.post(url,
        params, function(response) {
            $.mobile.hidePageLoadingMsg();
            if (response.status == 200) {
                console.log(response.merchant.auth_token);
                window.localStorage.setItem("gb_auth_token", response.merchant.auth_token);
                console.log(window.localStorage.getItem("gb_auth_token"));
                gb_auth_token = response.merchant.auth_token;
                $.mobile.changePage( "homeBeans.html", { transition: "slide"} );
                loadMyBeans();
            }
            console.log(response);
        }
    )
}

function loadMyBeans () {
    // var params = {
    // }
    // $.mobile.showPageLoadingMsg();
    // var url = 'http://107.20.196.96/api/consumer/beans/my_beans.json?auth_token=' + gb_auth_token;
    // $.get(url,
    //     params, function(response) {
    //         $.mobile.hidePageLoadingMsg();
    //         console.log(response);
    //     }
    // )
}

function getMyBeans() {
    var auth_token = window.localStorage.getItem("gb_auth_token");
    if (auth_token && auth_token.length > 0) {
        $.mobile.changePage( "homeBeans.html", { transition: "slide"} );
        gb_auth_token = auth_token;
        loadMyBeans();
    } else {
        $.mobile.changePage( "signup.html", { transition: "slide"} );
    }
}