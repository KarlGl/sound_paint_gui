# 
# This inits our gui with all the callbacks set up from the other module.
#

playSlider = require './standard-ui/play_slider.coffee'
buttons = require './standard-ui/buttons.coffee'
_ = require 'lodash'

# These callbacks have been kindly left for us by the frondend.
exports.getGlobalCallbacks = ->
  window.callbacks

exports.init = (area)->

  callbacks = exports.getGlobalCallbacks()

  btnHash = buttons.init(area)

  playSlider.init(area, (old)->
    # callback when play bar is slid.
    callbacks.playSlider(
      area: area
      # callback when play bar needs to be updated without triggering any more cbs.
      # cb: ()->
      old: old
      key: 'upto'
    ))

  initButtonToSendMessage = (name)->
    btnHash[name] (old)->
      callbacks[name](
        area: area
        old: old
        key: name
      )

  _.keys(btnHash).forEach (key)->
    initButtonToSendMessage key
  

