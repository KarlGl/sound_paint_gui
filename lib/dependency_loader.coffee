# 
# All dependencies for the application at it's top level.
# This file tells us how to load dependencies from the dependency list,
# with information on what each one needs to be initialized with.
# 
# It's called by the main class: sound_paint_gui.coffee
#

_ = require 'lodash'
dependencyList = require './dependency_list.coffee'
module.exports = 
  {
    # 
    # require a module and make an instance of it, calling "init" with "app".
    #
    requireAndInit: (dependency)->
      this[dependency.key] = dependency.instance.init(this)
    newInstance: ->
      toInitialize = {
        dependencies: dependencyList(),

        # 
        # Filter dependencies by a string in initializeWith array
        #
        for: (typeToInitWith)->
          this.dependencies.filter (dependency)->
            if (dependency.initializeWith?)
              _.contains(dependency.initializeWith, typeToInitWith)
      }

      this._ = _
      this.$ = require 'jquery'

      #
      # These classes will be saved to the app namespace
      #
      _.forEach toInitialize.dependencies, (dependency)=>
        this[dependency.key] = dependency.instance
      #
      # These classes will be initialized with the "app" object.
      #
      _.forEach toInitialize.for('app'), this.requireAndInit.bind(this)


      this.newAreaInstance = (area)->
        # 
        # use the same keys as class (but reset the keys that use an area).
        #
        area.app = _.clone(this)        
        
        requireAndInit = (dependency)->
          area.app[dependency.key] = area.app[dependency.key].init(area)

        _.forEach toInitialize.for('area'), requireAndInit
  }
