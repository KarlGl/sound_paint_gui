# 
# Draws blocks in a world.
# A block is a single drawn dot.
#

exports.init = (area, block)->
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