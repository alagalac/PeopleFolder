# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $(".vote-button").bind "ajax:success", (evt, data, status, xhr) ->
    $(this).toggleClass("btn-success")
    $(this).toggleClass("btn-default")
    $(this).html '<span class="glyphicon glyphicon-star"></span> ' + data

