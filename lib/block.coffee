# 
# Draws blocks in a world.
# A block is a single drawn dot.
#

colors = require './color_theme.coffee'
colors = colors.colors

exports.init = (area, block)->
  area.context.fillStyle = colors.units
  area.context.fillRect(
    block.x * area.len
    (1 - block.y) * area.len
    area.blockSize * area.len
    area.blockSize * area.len
  )


# exports.genBlock = (pos) ->
#   x: pos.x / clientArea.areaSizes
#   y: pos.y / clientArea.areaSizes
#   blockSize: exports.blockSize