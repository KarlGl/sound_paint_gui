exports.init = (area)->
    new: (params)->
      tool =
        name: params.name
        element: area.app.draw("<div class=\"btn tool #{params.name}\">#{params.name}</div>", params.container)
        set: (isActive)->
          if (isActive)
            this.element.removeClass('btn-off')
            this.element.addClass('btn-on')

            # 
            # updates to area state
            area.state["#{params.key}Active"] = this.name
            area.app.saveLoad.renderState()

            
            params.cssActive.call(this)

          else
            this.element.removeClass('btn-on')
            this.element.addClass('btn-off')
            params.cssInactive.call(this)
        pickADefault: ->
          if (name=area.state["#{params.key}Active"])
            if this.name == name
              this.set(true)

      tool.element.click ->
        params.coll.forEach (tool)->
          tool.set(false)
        tool.set(true)
      tool.pickADefault()
      
      params.coll.push tool

      tool
