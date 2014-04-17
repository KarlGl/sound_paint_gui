# This tracks mouse position.

colors = require './color_theme.coffee'
colors = colors.colors
draw = require './dom/draw.coffee'
_ = require 'lodash'

# for event listening
$ = require 'jquery'

exports.init = (params)->
  callbacks = params.callbacks
  down = false
  face = draw.draw('<div id="mouse-cursor"></div>')
      .css('position', 'absolute')
      .css('width', params.size + 'px')
      .css('height', params.size + 'px')
      .css('background-color', colors.mouse.inactive)

  _.each {
    mousemove: (event)-> 
      face.css('top', event.pageY + 'px')
      .css('left', event.pageX + 'px')
      callbacks.mousemove(event.pageX, event.pageY)
    mousedown: (event)->
        down = true
        face.css('background-color', colors.active)
        callbacks.mousedown()
    mouseup: (event)->
        down = false
        face.css('background-color', colors.mouse.inactive)
        callbacks.mouseup()
    }, 
    (val, key)->
      $("html")[key] val
