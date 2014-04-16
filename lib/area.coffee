# 
# This draws a new world.
#
block = require './block.coffee'
draw = require './dom/draw.coffee'

exports.draw = (params)->
  params.face = draw.draw('<canvas id="area"></canvas>')
  params.face.attr('width', params.len)
  params.face.attr('height', params.len)
  params.context = params.face[0].getContext("2d")

  params.units.forEach ((unit) ->
    block.init params, unit
  )
  params
