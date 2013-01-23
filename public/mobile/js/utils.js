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
                window.localStorage.setItem("gb_auth_token", response.merchant.auth_token);
                $.mobile.changePage( "homeBeans.html", { transition: "slide"} );
            }
            console.log(response);
        }
    )
}

function getMyBeans() {
    var auth_token = window.localStorage.getItem("gb_auth_token");
    if (auth_token && auth_token.length > 0) {
        $.mobile.changePage( "homeBeans.html", { transition: "slide"} );
    } else {
        $.mobile.changePage( "signup.html", { transition: "slide"} );
    }
}