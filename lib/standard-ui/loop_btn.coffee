# The btn to play and pause

btnLib = require '../dom/btn.coffee'
exports.init = (area, cb)->
  btnLib.init
    id: 'loop-btn'
    inner: 'Loop'
    parent: area
    key: 'isLooping'
    cb: cb
