
# exports.guiBuilder = guiBuilder
module.exports = 
  {
    require: ->
      _ = require 'lodash'
      $ = require 'jquery'
      draw = require './dom/draw.coffee'
      colors = require './color_theme.coffee'
      colors = colors.colors
      mouseTracker = require './mouse_tracker.coffee'
      soundHelpers = window.SPhelpers
      areaClass = require './area.coffee'
      areaDraw = require './area_draw.coffee'
      link = require './link.coffee'
      guiBuilder = require './gui_builder.coffee'

      resizer = require './standard-ui/resizer.coffee'
      tools = require './standard-ui/tools.coffee'
      
      this._ = _
      this.$ = $
      this.guiBuilder = guiBuilder 
      this.colors = colors
      this.mouseTracker = mouseTracker
      this.draw = draw.draw
      this.soundHelpers = soundHelpers
      this.areaClass = areaClass
      this.areaDraw = areaDraw
      this.link = link
      this.resizer = resizer
      this.tools = tools
  }
