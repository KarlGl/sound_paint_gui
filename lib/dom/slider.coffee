# 
# A slider
#

ui = require 'jquery-ui';
draw = require './draw.coffee'

exports.init = (params)->

  element = draw.draw("<div id=\"#{params.elementId}\"></div>")

  if (params.css.width)
    element.css('width', params.css.width)

  percision = 100000
  element.slider({
      min: 0,
      max: percision,
      change: ( event, ui )->
        old = params.parent[params.key]
        params.parent[params.key] = ui.value / percision
        # need a way to set value without triggering this.
        params.cb(old)
  })
  # do here so change will get called
  element.slider('option', 'value', params.parent[params.key] * percision)
  element



