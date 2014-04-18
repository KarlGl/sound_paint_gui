# 
# This inits our gui with all the callbacks set up from the core module.
# If these are not set (the module is not initialized) shit will fuck.
#

playSlider = require './standard-ui/play_slider.coffee'
buttons = require './standard-ui/buttons.coffee'
sliderWithMaxAndMin = require './dom/slider_with_max.coffee'
_ = require 'lodash'

exports.getGlobalCallbacks = ->
  window.callbacks

exports.init = (area)->

  callbacks = exports.getGlobalCallbacks()

  btnHash = buttons.init(area)

# SLIDERS
  playSlider.init(area, callbacks)
  speedSlider = sliderWithMaxAndMin.init(
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
  

