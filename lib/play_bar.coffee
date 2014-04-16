# The bar to play

draw = require './dom/draw.coffee'
playIndicator = require './play_indicator.coffee'
exports.init = (area)->
  bar = draw.draw('<div id="play-bar" style="height: 10px; background-color: grey;"></div>')
  bar.initial = area.initialPlayVal
  bar.w = area.width()
  bar.css('width', bar.w)
  playIndicator.init(
    bar
  )

