jQuery(document).ready(function($) {
    var alterClass = function() {
      var ww = document.body.clientWidth;
      if (ww < 600) {
        $('#left-nav').removeClass('sticky-top');
      } else if (ww >= 601) {
        $('#left-nav').addClass('sticky-top');
      };
    };
    $(window).resize(function(){
      alterClass();
    });
    alterClass();
});