# 
# A slider with max
#

ui = require 'jquery-ui'
draw = require './draw.coffee'
slider = require './slider.coffee'

exports.init = (params, callbacks)->
  max = 200
  element = slider.init(params, callbacks, 
    max: max
    )

