# 
# This draws a new world.
#
block = require './block.coffee'
areaDraw = require './area_draw.coffee'
positionLib = require './positions/positions.coffee'
_ = require 'lodash'

exports.addUnitCanditate = (area, unit)->
  # reject if duplicate
  if (!positionLib.isIn(area.state.units, unit) &&
    # don't allow them right on the very end
    !(unit.x == 1) &&
    !(unit.y == 0)
  ) 
    console.log("New Unit", unit)

    # here it is, we are changing state on the area
    area.state.units.push unit
    callbacks['units']({area: area})
    
    block.init area, unit

exports.init = (area)->
  area = areaDraw.init(area)
  exports.mouseInit(area)
  
  # just for debugging, will remove later
  window.globalarea = area
  area

exports.mouseInit = (area)->
  potentiallyMakeNewBlock = (mouseState)->
    if (mouseState.new.down)
      snappedPoint = positionLib.snapToGrid(mouseState.new.pos, area.state.blockSize * area.state.len)

      # for each area
      # back to a 0 to 1 position
      if newUnitPos = positionLib.isInBox(
          snappedPoint
          area.box
          )

        ['x', 'y'].forEach (axis)->
          gridHash = area.grid[axis]
          if (area.state['gridIsSnap_' + axis])
            newUnitPos[axis] = positionLib.snapToGridFromEquation(newUnitPos[axis], gridHash.get)

        # next time we play, this new unit will be there if created. 
        exports.addUnitCanditate(area, newUnitPos)

  area.mouseCallbacks = {
    mousemove: (mouseState)->
      potentiallyMakeNewBlock(mouseState)
    mousedown: (mouseState)->
      potentiallyMakeNewBlock(mouseState)
    mouseup: (mouseState)->
  }
