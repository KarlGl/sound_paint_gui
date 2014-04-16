# The slider to play

slider = require '../dom/slider.coffee'
exports.init = (area, cb)->
  slider.init
    elementId: 'play-bar',
    parent: area,
    key: 'upto',
    cb: cb,
    css: 
      width: area.len


