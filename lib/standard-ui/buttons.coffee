# The btn to play and pause

btnLib = require '../dom/btn.coffee'

exports.buttonList = [
  name: 'isPlaying'
  inner: 'advance'
,
  name: 'isLooping'
  inner: 'loop'
,
  name: 'gridIsShow_x'
  inner: 'Show Grid X'
,
  name: 'gridIsShow_y'
  inner: 'Show Grid Y'
,
  name: 'gridIsSnap_x'
  inner: 'Snap Grid X'
,
  name: 'gridIsSnap_y'
  inner: 'Snap Grid Y'
,
  # TO IMPL
  # name: 'isFreeplay'
  # inner: 'always playing'
]


exports.init = (area)->

  btnHash = {}

  # Use this method to add each toggle button.
  addStandardToggle = (params)->
    btnHash[params.name] = (cb)->
      btnLib.init
        id: "#{params.name}-btn"
        inner: "#{params.inner || params.name}"
        parent: area
        key: params.name
        cb: cb

  exports.buttonList.forEach (args)->
    # Only show if visible in the GUI is set.
    if area.state.visibleGuiControls[args.name]
      addStandardToggle args 

  btnHash
