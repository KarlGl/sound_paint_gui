# 
# This draws a new world.
#
draw = require './dom/draw.coffee'

exports.init = (area)->
  out =  
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

    #
    # potentially remove old container.
    # and make new one
    #
    drawContainer: ->
      this.destroy()
      area.container = area.app.draw("<div class=\"area-ct\"></div>")

    destroy: ->
      if (area.container?)
        area.container.remove()

    # Draw play indicator
    drawPlayIndicator: ->
      area.playIndicator =
        face: draw('<div class="play-indicator"></div>', area.container)
        setX: (newVal)->
          @face.css('left', (newVal * area.state.len) + area.box.left )
            .css('top', area.box.top)
      area.playIndicator.face.css('height', area.state.len)
        .css('left', 0)
        .css('background-color', area.app.colors.active)

    drawFace: ->
      # if (area.face?)
        # area.face.remove()  
      area.face = draw('<canvas class="area"></canvas><br/>', area.container)
      area.context = area.face[0].getContext("2d")

    drawUnits: ->
      # Draw all units.
      area.state.units.forEach (unit)->
        area.app.block.init unit


    # method to get a box for the element
    # we set it here since jquery gives us the position element to work with
    attachPositionAttributes: ->
      pos = area.face.position()
      area.box =
        top: pos.top 
        left: pos.left
        right: pos.left + area.face.width()
        bottom: pos.top + area.face.height()
  [
    # This must be first, it creates a container the others are drawn into
    'drawContainer'
    'drawPlayIndicator'
    'drawFace'
    'setSize'
    'drawUnits'
    'drawGrids'
    'attachPositionAttributes'
  ].forEach (k)=>
    out[k]()
  out
 
