# 
# This draws a new world.
#
app = require './app.coffee'
draw = require './dom/draw.coffee'
colors = require './color_theme.coffee'
block = require './block.coffee'
draw = draw


# Draw grids covering the area.
exports.drawGrids = (app, area)->
  fillFuncs = 
    x: (point)->
      area.context.fillRect(point, 0, 1, area.state.len)
    y: (point)->
      area.context.fillRect(0, (area.state.len - point), area.state.len, 1)
  ['x', 'y'].forEach (axis)->
    hash = area.grid[axis]
    if area.state['gridIsShow_' + axis]
      area.context.fillStyle = app.colors.inactive
      fill = (n)->
        # side effects in if statement
        if (pos = hash.get(n)) < 1
          fillFuncs[axis](pos * area.state.len)
          fill(n+1)
      fill(0)

#
# potentially remove old container.
# and make new one
#
exports.drawContainer = (app, area)->
  if (area.container?)
    area.container.remove()
  area.container = app.draw("<div class=\"area-ct\"></div>")

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
