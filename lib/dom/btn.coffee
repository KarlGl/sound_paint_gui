# 
# A generic button
#

ui = require 'jquery-ui';
draw = require './draw.coffee'

exports.init = (params)->
  btn = draw.draw("<div id=\"#{params.id}\">#{params.inner}</div>")
  size = 30
  btn.css('width', size)
  btn.css('height', size)
  btn.addClass('btn')

  set = (v)->
    if (params.parent[params.key] != v)
      old = params.parent[params.key]
      params.parent[params.key] = v
      params.cb(old)
    if params.parent[params.key]
      btn.addClass('btn-on')
      btn.css('background-color', 'green')
    else 
      btn.addClass('btn-off')
      btn.css('background-color', 'rgb(209, 209, 209)')

  set(params.parent[params.key])

  btn.click ->
    set(!params.parent[params.key])

