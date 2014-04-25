# 
# This builds the entire gui.
#
app = require './app.coffee'

exports.restartArea = (area)->
  exports.init(area)

# returns the resizer element
exports.init = (area)->
  #
  # Anything that doesn't need to call the globally accessable predefined callbacks for the other project, 
  # can be initialized here.
  #
  # Anything that does, goes in the link init.
  #
  
  #
  # this means any time we pass area we now can get to any module in the app.
  #
  app.newInstance(area)

  #
  # here, the bigest init call, for anything with a callback handled in the other project.
  #
  resizerEl = app.link.init(area)

  app.tools.init(app, area)

  app.mouseTracker.init(area)

  resizerEl

exports.initProgram = ->
  app.newInstance()

  app.resizer.setToMaximum(
    app, 
    exports.init(
      rootElement: app.rootElement.draw(),
      gridEquations: app.gridEquations(),
      state: app.defaultState,
    )
  )

# 
# use another execution thread to the one loading files.
#
setTimeout(exports.initProgram, 0)

