# 
# This draws a new world.
#
playBar = require './play_bar.coffee'
block = require './block.coffee'
draw = require './dom/draw.coffee'

exports.init = (params)->
  area = draw.draw('<canvas id="area"></canvas>')
  # world size in px.
  area.len = params.length
  area.attr('width', area.len)
  area.attr('height', area.len)
  area.context = area[0].getContext("2d")
  area.blockSize = params.blockSize
  area.initialPlayVal = params.initialPlayVal
  playBar.init(area)

  params.units.forEach ((unit) ->
    block.init area, unit
  )

exports.init({
  length: 300,
  blockSize: 0.02,
  initialPlayVal: 0.1,
  units: [
    {x: 0.25, y: 0.5},
    {x: 0.5, y: 0.4},
    {x: 0.75, y: 0.5},
  ]})

# exports.newBlock = (unit) ->
#   exports.worlds[0].units.push unit
#   exports.init()

# # Get the bounding box of a block.
# exports.getBlockBB = (block) ->
#   left = block.x * @areaSizes
#   left: left
#   right: left + block.blockSize * @areaSizes

# # Left side is allowed to be equal to, right is not.
# exports.getBlocksFor = (pos) ->
#   (if (exports.worlds.length and pos < exports.areaSizes) then exports.worlds[0].units.filter((unit) ->
#     pos >= exports.getBlockBB(unit).left and pos < exports.getBlockBB(unit).right
#   ) else [])

