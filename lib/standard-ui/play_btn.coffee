# The btn to play and pause

btnLib = require '../dom/btn.coffee'
exports.init = (area, cb)->
  btnLib.init
    id: 'play-btn'
    inner: 'Play'
    parent: area
    key: 'isPlaying'
    cb: cb
