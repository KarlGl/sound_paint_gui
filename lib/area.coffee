# 
# This draws a new world.
#
block = require './block.coffee'
areaDraw = require './area_draw.coffee'
positionLib = require './positions/positions.coffee'
_ = require 'lodash'

exports.addUnitCanditate = (area, unit)->
  # reject if duplicate
  if (!positionLib.isIn(area.units, unit) &&
    # don't allow them right on the very end
    !(unit.x == 1) &&
    !(unit.y == 0)
  ) 
    console.log("New Unit", unit)
    area.units.push unit
    block.init area, unit

exports.init = (area)->
  area = areaDraw.init(area)
  exports.mouseInit(area)
  window.globalarea = area
  area

exports.mouseInit = (area)->
  potentiallyMakeNewBlock = (mouseState)->
    if (mouseState.new.down)
      snappedPoint = positionLib.snapToGrid(mouseState.new.pos, area.blockSize * area.len)

      # for each area
      # back to a 0 to 1 position
      if newUnitPos = positionLib.isInBox(
          snappedPoint
          area.box
          )

        ['x', 'y'].forEach (axis)->
          gridHash = area.grid[axis]
          if (gridHash.isSnap)
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
