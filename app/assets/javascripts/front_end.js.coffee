# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $(window).scroll ->
    if $(".navbar").offset().top > 30
      $(".navbar-fixed-top").addClass "sticky"
    else
      $(".navbar-fixed-top").removeClass "sticky"