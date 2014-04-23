# 
# Draws blocks in a world.
# A block is a single drawn dot.
#

exports.init = (area, block)->
  area.context.fillStyle = 'black'#block.waveform.color
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