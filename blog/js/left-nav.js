jQuery(document).ready(function($) {
    var alterClass = function() {
      var ww = document.body.clientWidth;
      if (ww < 720) {
        $('#left-nav').removeClass('sticky-top');
      } else if (ww >= 720) {
        $('#left-nav').addClass('sticky-top');
      };
    };
    $(window).resize(function(){
      alterClass();
    });
    alterClass();
});