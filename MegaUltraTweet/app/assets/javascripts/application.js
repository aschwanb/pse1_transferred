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
//= require turbolinks
//= require masonry.pkgd.min
//= require jquery.slabtext.min
//= require_tree .


//Wrapper function needed because of a bug in turbolinks.
$(init = function init() {
    $(function () {
        msnry = new Masonry('#container', {
            columnWidth: 1,
            itemSelector: '.item'
        });
        msnry.bindResize();
    });

    $(function slabTextHeadlines() {
        $("h1").slabText({
            // Don't slabtext the headers if the viewport is under 380px
            "viewportBreakpoint": 380
        });
    });
});

$(document).ready(init);
$(document).on('page:load', init)