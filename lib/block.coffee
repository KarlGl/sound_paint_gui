# 
# Draws blocks in a world.
#

exports.init = (area, block)->
  area.context.fillRect(
    block.x * area.len
    block.y * area.len
    area.blockSize * area.len
    area.blockSize * area.len
  )

# exports.makeBlock = (pos) ->
#   clientArea.newBlock @genBlock(pos)  if pos.x < clientArea.areaSizes

# exports.genBlock = (pos) ->
#   x: pos.x / clientArea.areaSizes
#   y: pos.y / clientArea.areaSizes
#   blockSize: exports.blockSize