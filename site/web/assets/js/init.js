var initMaterialize = function() {
    console.log("initializing materialize..");
    $('.sidenav').sidenav();
    $('.parallax').parallax();
    $('.fixed-action-btn').floatingActionButton();
};

var closeSideBar = function() {
    $('.sidenav').close();
};