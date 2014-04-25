# 
# A slider
#

ui = require 'jquery-ui';
draw = require './draw.coffee'

# normalize true if you want it to be between 0..1
exports.init = (params, callbacks, overrides)->

  if params.parent.state.visibleGuiControls[params.key]
    cb = (old)->
      callbacks[params.key](
        area: params.parent
        old: old
        key: params.key
      )

    element = draw("<div id=\"#{params.key}\"></div>", params.parent.container)

    element.css('width', params.parent.face.width())

    percision = 100000
    element.slider({
        min: 0,
        max: 
          if overrides
            percision * overrides.max
          else
            percision
        change: ( event, ui )->
          old = params.parent.state[params.key]
          params.parent.state[params.key] = 
              ui.value / percision

          # need a way to set value without triggering this.
          cb(old)
    })
    # do here so change will get called
    element.slider('option', 'value', params.parent.state[params.key] * percision)
    element



