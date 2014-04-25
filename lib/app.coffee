
# exports.guiBuilder = guiBuilder
module.exports = 
  {
    require: ->
      this.rootElement = require './dom/root_element.coffee'
      this._ = require 'lodash'
      this.$ = require 'jquery'
      this.guiBuilder = require './gui_builder.coffee' 
      this.colors = require './color_theme.coffee'
      this.mouseTracker = require './mouse_tracker.coffee'
      this.draw = require './dom/draw.coffee'
      this.soundHelpers = window.SPhelpers # from other project
      this.areaClass = require './area.coffee'
      this.areaDraw = require './area_draw.coffee'
      this.link = require './link.coffee'
      this.resizer = require './standard-ui/resizer.coffee'
      this.tools = require './standard-ui/tools.coffee'
      this.gridEquations = require './positions/grid_equations.coffee'
      this.defaultState = require './defaults/default_state.coffee'
      this.json = require './dom/json.coffee'
      this.textArea = require './standard-ui/textarea.coffee'
  }
