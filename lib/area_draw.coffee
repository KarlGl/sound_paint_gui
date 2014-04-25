# 
# This draws a new world.
#
draw = require './dom/draw.coffee'

exports.init = (app)->
  init: (area)->
    # Draw grids covering the area.
    drawGrids: ->
      fillFuncs = 
        x: (point)->
          area.context.fillRect(point, 0, 1, area.state.len)
        y: (point)->
          area.context.fillRect(0, (area.state.len - point), area.state.len, 1)
      ['x', 'y'].forEach (axis)->
        hash = area.gridEquations[axis]
        if area.state['gridIsShow_' + axis]
          area.context.fillStyle = area.app.colors.inactive
          fill = (n)->
            # side effects in if statement
            if (pos = hash.get(n)) < 1
              fillFuncs[axis](pos * area.state.len)
              fill(n+1)
          fill(0)

    setSize: ->
      area.face.attr('width', area.state.len)
      area.face.attr('height', area.state.len)

      # Draw all units.
      area.state.units.forEach (unit)->
        area.app.block.init unit

    #
    # potentially remove old container.
    # and make new one
    #
    drawContainer: ->
      if (area.container?)
        area.container.remove()
      area.container = app.draw("<div class=\"area-ct\"></div>")

    init: ->
      # if (area.face?)
        # area.face.remove()  
      area.face = draw('<canvas class="area"></canvas><br/>', area.container)
      area.context = area.face[0].getContext("2d")
      pos = area.face.position()

      this.setSize()

    # Draw play indicator
      area.playIndicator =
        face: draw('<div class="play-indicator"></div>', area.container)
        setX: (newVal)->
          @face.css('left', (newVal * area.state.len) + pos.left )
          .css('top', pos.top)
      area.playIndicator.face.css('height', area.state.len)
        .css('background-color', area.app.colors.active)

      # method to get a box for the element
      area.box =
        top: pos.top 
        left: pos.left
        right: pos.left + area.face.width()
        bottom: pos.top + area.face.height()

      area
