# The btn to play and pause

btnLib = require '../dom/btn.coffee'

exports.buttonList = [
  name: 'isPlaying'
  inner: 'play'
,
  name: 'isLooping'
  inner: 'loop'
,
  name: 'isFreeplay'
  inner: 'always playing'
]


exports.init = (area)->

  btnHash = {}

  addStandardToggle = (params)->
    btnHash[params.name] = (cb)->
      btnLib.init
        id: "#{params.name}-btn"
        inner: "#{params.inner || params.name}"
        parent: area
        key: params.name
        cb: cb

  exports.buttonList.forEach (args)->
    addStandardToggle args 

  btnHash
