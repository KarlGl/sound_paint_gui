# 
# This draws a new world.
#
draw = require './dom/draw.coffee'
draw = draw.draw

exports.init = (area)->
  area.face = draw('<canvas id="area"></canvas>')
  area.face.attr('width', area.len)
  area.face.attr('height', area.len)
  area.context = area.face[0].getContext("2d")

  # method to get a box for the element
  pos = area.face.position()
  area.box =
    top: pos.top 
    left: pos.left
    right: pos.left + area.face.width()
    bottom: pos.top + area.face.height()

  area
