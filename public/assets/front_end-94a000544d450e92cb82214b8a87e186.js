(function() {
  jQuery(function() {
    return $(window).scroll(function() {
      if ($(".navbar").offset().top > 30) {
        return $(".navbar-fixed-top").addClass("sticky");
      } else {
        return $(".navbar-fixed-top").removeClass("sticky");
      }
    });
  });

}).call(this);
