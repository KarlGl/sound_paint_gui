#
# The tools such as pen, eraser, etc.
#

exports.init = (app)->
  init: (area)->
    #
    # save all tools in state, to corresponding tools on the direct area object.
    area.tools = []

    area.toolCt = app.draw("<div class=\"toolCt\"></div>", area.container)
      .css('border', "#{app.colors.active} 1px solid")
      .css('background-color', app.colors.barelyThere)

    area.state.tools.forEach (toolName)->
      tool = {}
      tool.name = toolName
      tool.set = (isActive)->
        if (isActive)
          this.element.removeClass('btn-off')
          this.element.addClass('btn-on')
          

          # 
          # updates to area state
          area.state.toolActive = this.name
          area.app.saveLoad.renderState()

          this.element.css('background-color', app.colors.active)
        else
          this.element.removeClass('btn-on')
          this.element.addClass('btn-off')
          this.element.css('background-color', app.colors.inactive)
      tool.exclusiveOptions = []
      if toolName == 'pen'
        tool.exclusiveOptions = area.state.waveforms
      tool.element = app.draw("<div class=\"btn tool #{toolName}\">#{toolName}</div>", area.toolCt)
      area.tools.push tool

    area.toolExclusiveOptionsCt = app.draw("<div class=\"waveCt\"></div>", area.toolCt)
      .css('border', "#{app.colors.active} 1px solid")
      .css('background-color', app.colors.inactive)

    area.tools.forEach (tool)->
      tool.exclusiveOptionInstances = []
      tool.exclusiveOptions.forEach (optionConfig)->
        option = {}
        option.name = optionConfig.name
        option.active = false
        option.set = (isActive)->
            if (isActive)
              this.element.removeClass('btn-off')
              this.element.addClass('btn-on')
              area.state.optionActive = this.name
              area.app.saveLoad.renderState()
              
              this.element.css("border", "#{app.colors.active} 6px solid")
            else
              this.element.removeClass('btn-on')
              this.element.addClass('btn-off')
              this.element.css("border", "none")
        option.element = app.draw("<div class=\"option btn\">#{optionConfig.name}</div>", area.toolExclusiveOptionsCt)
          .css('background-color', optionConfig.color)
          .css('color', 'white')

        option.element.click ->
          tool.exclusiveOptionInstances.forEach (option)->
            option.set(false)
          option.set(true)
        tool.exclusiveOptionInstances.push option
      
      if (ar = tool.exclusiveOptionInstances).length
        ar[0].set(true)

      if (name=area.state.optionActive)
        app._.find(tool.exclusiveOptionInstances, (option)-> 
          option.name == name)
        .set(true)

      tool.element.click ->
        area.tools.forEach (tool)->
          tool.set(false)
        tool.set(true)

    if (name=area.state.toolActive)
      app._.find(area.tools, (tool)-> 
        tool.name == name)
      .set(true)

