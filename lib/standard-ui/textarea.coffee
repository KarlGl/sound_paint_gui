
ui = require 'jquery-ui';
draw = require '../dom/draw.coffee'

exports.init = (params, callbacks, overrides)->

  if params.parent.visibleGuiControls[params.key]
    cb = (old)->
      callbacks[params.key](
        area: params.parent
        old: old
        key: params.key
      )

    element = draw.draw("<div id=\"#{params.key}\"></div>", params.parent.container)

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
          old = params.parent[params.key]
          params.parent[params.key] = 
              ui.value / percision

          # need a way to set value without triggering this.
          cb(old)
    })
    # do here so change will get called
    element.slider('option', 'value', params.parent[params.key] * percision)
    element

