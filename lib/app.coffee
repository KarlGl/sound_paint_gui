# 
# All dependancies for the application at it's top level.
# This file is just a glorified dependency list.
#

_ = require 'lodash'
module.exports = 
  {
    # 
    # require a module and make an instance of it, calling "init" with "app".
    #
    requireAndInit: (instance, key)->
      this[key] = instance.init(this)
    newInstance: ->
      this._ = _
      this.$ = require 'jquery'

      #
      # These classes will be initialized with the "app" object.
      #
      _.forEach {
          rootElement: (require './dom/root_element.coffee')
          colors: (require './color_theme.coffee')
          mouseTracker: (require './mouse_tracker.coffee')
          gridEquations: (require './positions/grid_equations.coffee')
          areaDraw: (require './area_draw.coffee')
          areaUnits: (require './area_units.coffee')
          block: (require './block.coffee')
        }, this.requireAndInit.bind(this)

      this.guiBuilder = require './gui_builder.coffee' 
      this.draw = require './dom/draw.coffee'
      this.soundHelpers = window.SPhelpers # from other project
      this.link = require './link.coffee'
      this.resizer = require './standard-ui/resizer.coffee'
      this.tools = require './standard-ui/tools.coffee'
      this.defaultState = require './defaults/default_state.coffee'
      this.json = require './dom/json.coffee'
      this.textArea = require './standard-ui/textarea.coffee'
      this.newInstance = (area)->
        # 
        # use the same keys as class (but reset the keys that use an area).
        #
        area.app = _.clone(this)
        
        area.app.requireAndInit = (key)->
          this[key] = this[key].init(area)

        #
        # These classes will be initialized with an "area" object.
        # order could possibly be important here
        #
        [
          'areaDraw'
          'areaUnits'
          'block'
        ].forEach (key)->
          area.app.requireAndInit(key)
  }
