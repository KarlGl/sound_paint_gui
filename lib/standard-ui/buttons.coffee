# The btn to play and pause

btnLib = require '../dom/btn.coffee'
exports.init = (area)->

  btnHash = {}

  addStandardToggle = (params)->
    btnHash[params.name] = (cb)->
      btnLib.init
        id: "#{params.name}-btn"
        inner: "#{params.name}"
        parent: area
        key: params.name
        cb: cb

  [
    'isPlaying'
    'isLooping'
  ].forEach (key)->
    addStandardToggle 
      name: key 

  btnHash
