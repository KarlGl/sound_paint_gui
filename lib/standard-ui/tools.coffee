#
# The tools such as pen, eraser, etc.
#

exports.init = (area)->
    #
    # save all tools in state, to corresponding tools on the direct area object.
    area.tools = []

    area.toolCt = area.app.draw("<div class=\"toolCt\"></div>", area.container)
      .css('border', "#{area.app.colors.active} 1px solid")
      .css('background-color', area.app.colors.barelyThere)

    area.state.tools.forEach (toolConfig)->
      tool = area.app.exclusiveButton.new(
        name: toolConfig.name, 
        key: 'tool',
        cssActive: ->
          this.element.css('background-color', area.app.colors.active)
        cssInactive: ->
          this.element.css('background-color', area.app.colors.inactive)
        container: area.toolCt
        coll: area.tools
        )
      
      if tool.name == 'pen'
        tool.exclusiveOptions = area.state.waveforms
      else
        tool.exclusiveOptions = []

    area.toolExclusiveOptionsCt = area.app.draw("<div class=\"waveCt\"></div>", area.toolCt)
      .css('border', "#{area.app.colors.active} 1px solid")
      .css('background-color', area.app.colors.inactive)

    area.tools.forEach (tool)->
      tool.exclusiveOptionInstances = []
      tool.exclusiveOptions.forEach (optionConfig)->
        option = area.app.exclusiveButton.new(
          name: optionConfig.name, 
          key: 'option',
          cssActive: ->
            this.element.css("border", "#{area.app.colors.active} 6px solid")
          cssInactive: ->
            this.element.css("border", "none")
          container: area.toolExclusiveOptionsCt
          coll: tool.exclusiveOptionInstances
        )
        option.element
          .css('background-color', optionConfig.color)
          .css('color', 'white')

    area.tools


