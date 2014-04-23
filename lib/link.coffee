# 
# This inits our gui with all the callbacks set up from the core module.
# If these are not set (the module is not initialized) shit will fuck.
#

playSlider = require './standard-ui/play_slider.coffee'
buttons = require './standard-ui/buttons.coffee'
sliderWithMaxAndMin = require './dom/slider_with_max.coffee'
resizer = require './standard-ui/resizer.coffee'
_ = require 'lodash'

exports.getGlobalCallbacks = ->
  window.callbacks

exports.init = (area)->
  callbacks = exports.getGlobalCallbacks()

  btnHash = buttons.init(area)

# SLIDERS
  playSliderEl = playSlider.init(area, callbacks)
  speedSliderEl = sliderWithMaxAndMin.init(
      parent: area,
      key: 'bpm'
    , callbacks)


  initButtonToSendMessage = (name)->
    btnHash[name] (old)->
      callbacks[name](
        area: area
        old: old
        key: name
      )

  _.keys(btnHash).forEach (key)->
    initButtonToSendMessage key


  # Make sure this is called last.
  # After the initialization code, there's a call to resize to max possible size 
  if (area.visibleGuiControls.len)
    resizerEl = resizer.init(
      key: 'areaResize'
      parent: area
      callbacks: callbacks
    )
    resizerEl


  

