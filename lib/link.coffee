# 
# This inits our gui with all the callbacks set up from the other module.
#

playBar = require './standard-ui/play_slider.coffee'
playBtn = require './standard-ui/play_btn.coffee'
loopBtn = require './standard-ui/loop_btn.coffee'

# These callbacks have been kindly left for us by the frondend.
exports.getGlobalCallbacks = ->
  window.callbacks

exports.init = (area)->

  callbacks = exports.getGlobalCallbacks()

  playBar.init(area, (old)->
    # callback when play bar is slid.
    callbacks.playBar(
      area: area
      # callback when play bar needs to be updated without triggering any more cbs.
      cb: ()->
      old: old
      key: 'upto'
    ))
  playBtn.init(area, (old)->
    # callback when play button is pressed.
    callbacks.playBtn(
      area: area
      cb: ->
      old: old
      key: 'isPlaying'
    ))
  loopBtn.init(area, (old)->
    # callback when loop button is pressed.
    callbacks.loopBtn(
      area: area
      cb: ->
      old: old
      key: 'isLooping'
    ))

