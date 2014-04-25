# 
# A block in the area.
# A block is a single drawn dot.
#

exports.init = (app)->
  init: (area)->
    init: (block)->
      area.context.fillStyle = 'black'#block.waveform.color
      area.context.fillRect(
        block.x * area.state.len
        (1 - block.y) * area.state.len
        area.state.blockSize * area.state.len
        area.state.blockSize * area.state.len
      )
