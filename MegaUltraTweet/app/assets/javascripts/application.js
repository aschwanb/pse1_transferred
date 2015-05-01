// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

/*$(function () {

    // Prepare
    var History = window.History; // Note: We are using a capital H instead of a lower h
    if ( !History.enabled ) {
        // History.js is disabled for this browser.
        // This is because we can optionally choose to support HTML4 browsers or not.
        return false;
    }

    // Bind to StateChange Event
    History.Adapter.bind(window,'statechange',function() { // Note: We are using statechange instead of popstate
        var State = History.getState();
        $('.se-pre-con').fadeOut("fast");
    });

    // Capture all the links to push their url to the history stack and trigger the StateChange Event
    $('a').click(function(evt) {
        //evt.preventDefault();
        History.pushState(null, $(this).text(), $(this).attr('href'));
    });

});

$(init = function init() {

    $('a').click(function(evt) {
        //evt.preventDefault();
        History.pushState(null, $(this).text(), $(this).attr('href'));
    });

    $(function() {
        $(".continue-button").click(function() {
            $(".se-pre-con").fadeIn("slow");
            //setTimeout(function () {
            //    $('.se-pre-con').fadeOut("fast")}, 10000);
        });
    });
    $(function() {
        $(".search").submit(function() {
            $(".se-pre-con").fadeIn("slow");
            //setTimeout(function () {
            //    $('.se-pre-con').fadeOut("fast")}, 3000);
        });
    });

});*/

//$(loader_after = function() {
//    $(".se-pre-con").fadeOut("slow");
//});

//$(document).ready(init);
//$(document).on('page:load', init);
//$(window).on('page:load', loader_after);

//Wrapper function needed because of a bug in turbolinks.
//$(init = function init() {
//    $(function () {
//        msnry = new Masonry('#container', {
//            columnWidth: 1,
//            itemSelector: '.item'
//        });
//        msnry.bindResize();
//    });
//
//    $(function slabTextHeadlines() {
//        $("h1").slabText({
//            // Don't slabtext the headers if the viewport is under 380px
//            "viewportBreakpoint": 380
//        });
//    });
//});
//
//$(document).ready(init);
//$(document).on('page:load', init)