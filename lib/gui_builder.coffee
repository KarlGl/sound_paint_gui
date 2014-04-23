# 
# This builds the entire gui.
#
link = require './link.coffee'
areaClass = require './area.coffee'
draw = require './dom/draw.coffee'
mouseTracker = require './mouse_tracker.coffee'
resizer = require './standard-ui/resizer.coffee'
$ = require 'jquery'
colors = require './color_theme.coffee'
colors = colors.colors
# from the other project
soundHelpers = window.SPhelpers

exports.init = (area)->
  #
  # Anything that doesn't need to call the globally accessable predefined callbacks, 
  # can be initialized here.
  #
  # Anything that does, goes in the link init.
  #

  # potentially remove old container.
  if (area.container?)
    area.container.remove()
  area.container = draw.draw("<div class=\"area-ct\"></div>")
  area = areaClass.init(area)

  area.restart = ->
    exports.init(area)

  # Draw grids.
  fillFuncs = 
    x: (point)->
      area.context.fillRect(point, 0, 1, area.len)
    y: (point)->
      area.context.fillRect(0, (area.len - point), area.len, 1)
  ['x', 'y'].forEach (axis)->
    hash = area.grid[axis]
    if area['gridIsShow_' + axis]
      area.context.fillStyle = colors.inactive
      fill = (n)->
        # side effects in if statement
        if (pos = hash.get(n)) < 1
          fillFuncs[axis](pos * area.len)
          fill(n+1)
      fill(0)


  resizerEl = link.init(area)
  mouseTracker.init
    size: 10
    callbacks: area.mouseCallbacks
  resizerEl

# if $('.sound-paint').length
rootElement = draw.draw("<div class=\"sound-paint\"></div>", $('body'))
rootElement.css('width', '100%')
rootElement.css('height', '100%')

area = {
  rootElement: rootElement,
  grid: {
      x: {
        get: (n)->
          1/16 * n
      } 
      y: {
        get: (n)->
          b=Math.pow(1.059463, n)
          soundHelpers.humanEar.freqToRange(27.5*b)
      }
    },

  state: {
    len: 300,
    blockSize: 0.02,
    playSlider: 0.09,
    bpm: 6,
    isPlaying: false,
    isLooping: true,

    visibleGuiControls: {
      isPlaying: true,
      isLooping: true,
      playSlider: true,
      gridIsSnap_x: true,
      gridIsShow_x: true,
      gridIsSnap_y: true,
      gridIsShow_y: true,
      bpm: true,
      len: true,
      stateInput: true
    },

    gridIsSnap_x: false,
    gridIsShow_x: false,
    gridIsSnap_y: true,
    gridIsShow_y: true,
    
    units: [
      # {x: 0.25, y: 0.1},
      # {x: 0.5, y: 0.2},
      # {x: 0.75, y: 0.1},
    ]
    }
  }
# side effects
initialized = exports.init(area)

if (area.visibleGuiControls.len)
  resizer.setToMaximum(initialized)

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

