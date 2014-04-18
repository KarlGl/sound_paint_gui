# 
# This draws a new world.
#
draw = require './dom/draw.coffee'
colors = require './color_theme.coffee'
colors = colors.colors
draw = draw.draw

exports.init = (area)->
  area.face = draw('<canvas class="area"></canvas>')
  area.face.attr('width', area.len)
  area.face.attr('height', area.len)
  area.context = area.face[0].getContext("2d")
  pos = area.face.position()

  area.playIndicator =
    face: draw('<div class="play-indicator"></div>')
    setX: (newVal)->
      @face.css('left', (newVal * area.len) + pos.left )
      .css('top', pos.top)
  area.playIndicator.face.css('height', area.len)
    .css('background-color', colors.active)

  # method to get a box for the element
  area.box =
    top: pos.top 
    left: pos.left
    right: pos.left + area.face.width()
    bottom: pos.top + area.face.height()

  area
