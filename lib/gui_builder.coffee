# 
# God class.
# This builds the entire gui.
#
link = require './link.coffee'
area = require './area.coffee'
mouseTracker = require './mouse_tracker.coffee'

exports.init = (params)->
  params = area.init(params)
  link.init(params)
  mouseTracker.init
    size: 10
    callbacks: params.mouseCallbacks


exports.init({
  len: 300,
  blockSize: 0.02,
  upto: 0.1,
  isPlaying: true,
  isLooping: false,
  units: [
    # {x: 0.25, y: 0.1},
    # {x: 0.5, y: 0.2},
    # {x: 0.75, y: 0.1},
  ]})

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

