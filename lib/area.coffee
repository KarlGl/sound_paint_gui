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
      # for each area
      if (newUnitPos = positionLib.isInBox(
          positionLib.snapToGrid(mouseState.new.pos, area.blockSize * area.len)
          area.box
        ))
          # next time we play, this new unit will be there if created. 
          exports.addUnitCanditate(area, newUnitPos)

  area.mouseCallbacks = {
    mousemove: (mouseState)->
      potentiallyMakeNewBlock(mouseState)
    mousedown: (mouseState)->
      potentiallyMakeNewBlock(mouseState)
    mouseup: (mouseState)->
  }
