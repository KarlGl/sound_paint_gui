# 
# This builds the entire gui.
#
app = require './app.coffee'

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
  area.container = app.draw("<div class=\"area-ct\"></div>")

  #init area
  area = app.areaClass.init(area)

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
      area.context.fillStyle = app.colors.inactive
      fill = (n)->
        # side effects in if statement
        if (pos = hash.get(n)) < 1
          fillFuncs[axis](pos * area.state.len)
          fill(n+1)
      fill(0)

  #
  # here, the bigest init call, for anything with a callback handled in the other project.
  #
  resizerEl = app.link.init(area)

  tools.init(area)

  app.mouseTracker.init
    size: 10
    callbacks: area.mouseCallbacks
  resizerEl

exports.initProgram = ->
  app.require()
  rootElement = app.draw("<div class=\"sound-paint\"></div>", app.$('body'))
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
    toolActive: 'pen',
    optionActive: 'sin',
    waveforms: [
      {
        active: true,
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
            app.soundHelpers.humanEar.freqToRange(27.5*b)
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

setTimeout(exports.initProgram,0)

