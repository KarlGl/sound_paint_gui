# 
# This handles everything an area has about it's units.
#
positionLib = require './positions/positions.coffee'

exports.init = (area)->
    out = {
      addUnitCanditate: (unit)->
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
          
          area.app.block.init unit

      mouseInit: ->
        potentiallyMakeNewBlock = (mouseState)=>
          if (mouseState.new.down)
            snappedPoint = positionLib.snapToGrid(mouseState.new.pos, area.state.blockSize * area.state.len)

            # for each area
            # back to a 0 to 1 position
            if newUnitPos = positionLib.isInBox(
                snappedPoint
                area.box
                )

              ['x', 'y'].forEach (axis)->
                gridHash = area.gridEquations[axis]
                if (area.state['gridIsSnap_' + axis])
                  newUnitPos[axis] = positionLib.snapToGridFromEquation(newUnitPos[axis], gridHash.get)

              # next time we play, this new unit will be there if created. 

              newUnitPos.waveName = area.state.optionActive
              this.addUnitCanditate(newUnitPos)

        area.mouseCallbacks = {
          mousemove: (mouseState)->
            potentiallyMakeNewBlock(mouseState)
          mousedown: (mouseState)->
            potentiallyMakeNewBlock(mouseState)
          mouseup: (mouseState)->
        }
        area
      }
      
    # call on init 
    out.mouseInit()

