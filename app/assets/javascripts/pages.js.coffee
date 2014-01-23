# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  txt = $("#wmd-input")
  hiddenDiv = $(document.createElement("div"))
  content = null
  txt.addClass "txtstuff"
  hiddenDiv.addClass "hiddendiv common"
  $("body").append hiddenDiv
  txt.on "keyup", ->
    content = $(this).val()
    content = content.replace(/\n/g, "<br>")
    hiddenDiv.html content + "<br class=\"lbr\">"
    $(this).css "height", hiddenDiv.height() + 15


  btnbr = $("#wmd-button-bar")
  btnbr.on "click", ->
    content = $("#wmd-input").val()
    content = content.replace(/\n/g, "<br>")
    hiddenDiv.html content + "<br class=\"lbr\">"
    $("#wmd-input").css "height", hiddenDiv.height() + 15




