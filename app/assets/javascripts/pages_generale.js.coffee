# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

###
EXEMPLE COFFEESCRIPT

@paintIt = (element, backgroundColor, textColor) ->
  element.style.backgroundColor = backgroundColor
  if textColor?
    element.style.color = textColor

$ ->
  $("a[data-background-color]").click (e) ->
    e.preventDefault()

    backgroundColor = $(this).data("background-color")
    textColor = $(this).data("text-color")
    paintIt(this, backgroundColor, textColor)


HAML:
  %a{"data-background-color" => "#990000", :href => "#"} Paint it red
  %a{"data-background-color" => "#009900", "data-text-color" => "#FFFFFF", :href => "#"} Paint it green
  %a{"data-background-color" => "#000099", "data-text-color" => "#FFFFFF", :href => "#"} Paint it blue

###