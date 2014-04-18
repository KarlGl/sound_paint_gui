# 
# This draws a new world.
#
block = require './block.coffee'
areaDraw = require './area_draw.coffee'
positionLib = require './positions/positions.coffee'
_ = require 'lodash'

exports.addUnitCanditate = (area, unit)->
  # reject if duplicate
  if (!positionLib.isIn(area.units, unit))
    area.units.push unit
    block.init area, unit

exports.init = (area)->
  area = areaDraw.init(area)

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

  window.area = area
  area
