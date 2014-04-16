# The little nob in the bar

draw = require './dom/draw.coffee'

exports.init = (bar)->
  indicator = draw.draw(
    '<div id="play-indicator"></div>', bar)
  indicator.set = (v)->
    this.css('left', bar.w * v)

  indicator.set(bar.initial)

