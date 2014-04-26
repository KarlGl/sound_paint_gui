#
# This tracks mouse position.
# Fires callbacks for mouse events.
#

colors = require './color_theme.coffee'
draw = require './dom/draw.coffee'
_ = require 'lodash'

# for event listening
$ = require 'jquery'

exports.init = (area)->
    callbacks = area.mouseCallbacks
    size = 10
    down = false
    # face = draw('<div id="mouse-cursor"></div>')
    if (face?)
      face.css('position', 'absolute')
        .css('width', size + 'px')
        .css('height', size + 'px')
        .css('background-color', colors.mouse.inactive)

    defaultState = 
      pos: 
        x: null
        y: null
      down: false
    states = 
      new: _.cloneDeep(defaultState)
      old: _.cloneDeep(defaultState)

    copyNewToOld = ->
      states.old = _.cloneDeep(states.new)

    _.each {
      mousemove: (event)->
        copyNewToOld()
        # update x and y on new
        states.new.pos.x = event.pageX
        states.new.pos.y = event.pageY

        if (face?)
          face.css('top', event.pageY + 'px')
            .css('left', event.pageX + 'px')
        callbacks.mousemove(states)
      mousedown: (event)->
        copyNewToOld()
        states.new.down = true
        if (face?)
          face.css('background-color', colors.active)
        callbacks.mousedown(states)
      mouseup: (event)->
        copyNewToOld()
        states.new.down = false
        if (face?)
          face.css('background-color', colors.mouse.inactive)
        callbacks.mouseup(states)
      }, 
      (val, key)->
        $("html")[key] val
