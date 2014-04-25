# 
# This builds the entire gui.
#
app = require './app.coffee'

# returns the resizer element
exports.init = (area)->
  #
  # Anything that doesn't need to call the globally accessable predefined callbacks for the other project, 
  # can be initialized here.
  #
  # Anything that does, goes in the link init.
  #
  
  area.restartGUI = ->
    exports.init(area)
  #
  # (a reference from area to app gets set in this method) 
  # this means any time we pass area we now can get to any module in the app.
  #
  app.newInstance(area)


# the big bang...
exports.initProgram = ->
  app.newInstance()

  exports.init(
    rootElement: app.rootElement.draw(),
    gridEquations: app.gridEquations(),
    state: app.defaultState
  )

# 
# use another execution thread to the one loading files.
#
setTimeout(exports.initProgram, 0)

