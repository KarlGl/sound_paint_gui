# 
# A generic button
#

ui = require 'jquery-ui';
draw = require './draw.coffee'
colors = require('../color_theme.coffee')

size = 30

exports.init = (params)->
  btn = draw("<div id=\"#{params.id}\">#{params.inner}</div>", params.parent.container)
  # btn.css('width', size)
  btn.css('height', size)
  btn.addClass('btn')

  set = (v)->
    if (params.parent.state[params.key] != v)
      old = params.parent.state[params.key]
      params.parent.state[params.key] = v
      params.cb(old)
    if params.parent.state[params.key]
      btn.addClass('btn-on')
      btn.css('background-color', colors.active)
    else 
      btn.addClass('btn-off')
      btn.css('background-color', colors.inactive)

  set(params.parent.state[params.key])

  btn.click ->
    set(!params.parent.state[params.key])

