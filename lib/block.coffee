# 
# Draws blocks in a world.
# A block is a single drawn dot.
#

colors = require './color_theme.coffee'
colors = colors.colors

exports.init = (area, block)->
  area.context.fillStyle = colors.units
  area.context.fillRect(
    block.x * area.state.len
    (1 - block.y) * area.state.len
    area.state.blockSize * area.state.len
    area.state.blockSize * area.state.len
  )


# exports.genBlock = (pos) ->
#   x: pos.x / clientArea.areaSizes
#   y: pos.y / clientArea.areaSizes
#   blockSize: exports.state.blockSize