# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $("#new_comment").bind "ajax:success", (evt, data, status, xhr) ->
    comment = $("<li>",
        class: "list-group-item"
      ).html data.content


    $('#comments').append comment

    $('#comment_content').val ''


jQuery ->
  $(".delete_comment").bind "ajax:success", (evt, data, status, xhr) ->
    $(evt.target).parent().remove()
