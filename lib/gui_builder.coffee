# 
# God class.
# This builds the entire gui.
#
link = require './link.coffee'
areaClass = require './area.coffee'
draw = require './dom/draw.coffee'
mouseTracker = require './mouse_tracker.coffee'
resizer = require './standard-ui/resizer.coffee'
$ = require 'jquery'

exports.init = (area)->
  # potentially remove old container.
  if (area.container?)
    area.container.remove()

  area.container = draw.draw("<div class=\"area-ct\"></div>")
  area.container.parentContainer = 

  area = areaClass.init(area)
  resizerEl = link.init(area)
  mouseTracker.init
    size: 10
    callbacks: area.mouseCallbacks
  resizerEl

# if $('.sound-paint').length
rootElement = draw.draw("<div class=\"sound-paint\"></div>", $('body'))
rootElement.css('width', '100%')
rootElement.css('height', '100%')


resizer.setToMaximum(
 exports.init({
  len: 300,
  blockSize: 0.02,
  playSlider: 0.09,
  bpm: 15,
  isPlaying: false,
  isLooping: false,
  units: [
    {x: 0.25, y: 0.1},
    {x: 0.5, y: 0.2},
    # {x: 0.75, y: 0.1},
  ],
  rootElement: rootElement
  })
)

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

