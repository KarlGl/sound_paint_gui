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

colors = require('./color_theme.coffee')
colors = colors.colors

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
      area.context.fillRect(point, 0, 1, area.state.len)
    y: (point)->
      area.context.fillRect(0, (area.state.len - point), area.state.len, 1)
  ['x', 'y'].forEach (axis)->
    hash = area.grid[axis]
    if area.state['gridIsShow_' + axis]
      area.context.fillStyle = colors.inactive
      fill = (n)->
        # side effects in if statement
        if (pos = hash.get(n)) < 1
          fillFuncs[axis](pos * area.state.len)
          fill(n+1)
      fill(0)

  #
  # here
  #
  resizerEl = link.init(area)


  #
  # save all tools in state, to corresponding tools on the direct area object. This object contains
  area.tools = []

  area.toolCt = draw.draw("<div class=\"toolCt\"></div>", area.container)
    .css('border', "#{colors.active} 1px solid")
    .css('background-color', colors.barelyThere)
  

  area.state.tools.forEach (toolName)->
    tool = {}
    tool.active = false
    tool.set = (isActive)->
      if (isActive)
        this.element.removeClass('btn-off')
        this.element.addClass('btn-on')
        this.active = true
        this.element.css('background-color', colors.active)
      else
        this.active = false
        this.element.removeClass('btn-on')
        this.element.addClass('btn-off')
        this.element.css('background-color', colors.inactive)
    tool.exclusiveOptions = []
    if toolName == 'pen'
      tool.exclusiveOptions = area.state.waveforms
    tool.element = draw.draw("<div class=\"btn tool #{toolName}\">#{toolName}</div>", area.toolCt)
    area.tools.push tool

  area.toolExclusiveOptionsCt = draw.draw("<div class=\"waveCt\"></div>", area.toolCt)
    .css('border', "#{colors.active} 1px solid")
    .css('background-color', colors.inactive)

  area.tools.forEach (tool)->
    tool.exclusiveOptionInstances = []
    tool.exclusiveOptions.forEach (optionConfig)->
      option = {}
      option.active = false
      option.set = (isActive)->
          if (isActive)
            this.element.removeClass('btn-off')
            this.element.addClass('btn-on')
            this.active = true
            this.element.css("border", "#{colors.active} 6px solid")
          else
            this.active = false
            this.element.removeClass('btn-on')
            this.element.addClass('btn-off')
            this.element.css("border", "none")
      option.element = draw.draw("<div class=\"option btn\">#{optionConfig.name}</div>", area.toolExclusiveOptionsCt)
        .css('background-color', optionConfig.color)
        .css('color', 'white')

      option.element.click ->
        tool.exclusiveOptionInstances.forEach (option)->
          option.set(false)
        option.set(true)
      tool.exclusiveOptionInstances.push option
    
    if (ar = tool.exclusiveOptionInstances).length
      ar[0].set(true)


    tool.element.click ->
      area.tools.forEach (tool)->
        tool.set(false)
      tool.set(true)

  if (area.tools.length)
    area.tools[0].set true


  # end tools

  mouseTracker.init
    size: 10
    callbacks: area.mouseCallbacks
  resizerEl

rootElement = draw.draw("<div class=\"sound-paint\"></div>", $('body'))
rootElement.css('width', '100%')
rootElement.css('height', '100%')

startState = {
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
  ],
  tools: ['pen'],
  waveforms: [
    {
      name: 'sin',
      color: "#6a00ff"
    },
    {
      name: 'sqr',
      color: "#0000ff"
    },
  ]
}
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

  startState: startState
  state: startState
}
# side effects
initialized = exports.init(area)

  # snap to max len at the start?
if (area.state.visibleGuiControls.len)
  resizer.setToMaximum(initialized)

