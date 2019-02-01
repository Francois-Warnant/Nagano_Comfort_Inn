# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

@addRoomToReservation = (element) ->
  element.style.color = "white"



@setDatePicker = () ->
  $("#check_in").datepicker(
    format: 'yyyy-mm-dd'
  )
  $("#check_out").datepicker(
    format: 'yyyy-mm-dd'
  )

