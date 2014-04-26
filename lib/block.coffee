# 
# Methods for the unit in an area. 
# Related to waveforms and drawing.
#

exports.init = (area)->

  currentWaveform: ()->
    name = area.state.optionActive
    area.app._.find(area.state.waveforms, (waveform)->
      waveform.name is name
    )

  init: (block)->
    area.context.fillStyle = this.currentWaveform().color
    area.context.fillRect(
      block.x * area.state.len
      (1 - block.y) * area.state.len
      area.state.blockSize * area.state.len
      area.state.blockSize * area.state.len
    )
