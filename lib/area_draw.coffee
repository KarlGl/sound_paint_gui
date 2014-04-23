# 
# This draws a new world.
#
draw = require './dom/draw.coffee'
colors = require './color_theme.coffee'
block = require './block.coffee'
colors = colors.colors
draw = draw.draw


exports.setSize = (areaParam)->
  areaParam.face.attr('width', areaParam.state.len)
  areaParam.face.attr('height', areaParam.state.len)

  # Draw all units.
  areaParam.state.units.forEach (unit)->
    block.init areaParam, unit

exports.init = (area)->
  # if (area.face?)
    # area.face.remove()  
  area.face = draw('<canvas class="area"></canvas><br/>', area.container)
  area.context = area.face[0].getContext("2d")
  pos = area.face.position()

  exports.setSize(area)

# Draw play indicator
  area.playIndicator =
    face: draw('<div class="play-indicator"></div>', area.container)
    setX: (newVal)->
      @face.css('left', (newVal * area.state.len) + pos.left )
      .css('top', pos.top)
  area.playIndicator.face.css('height', area.state.len)
    .css('background-color', colors.active)

  # method to get a box for the element
  area.box =
    top: pos.top 
    left: pos.left
    right: pos.left + area.face.width()
    bottom: pos.top + area.face.height()

  area
