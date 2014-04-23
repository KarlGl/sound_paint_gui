
ui = require 'jquery-ui';
draw = require '../dom/draw.coffee'
guiInit = require '../gui_builder.coffee'
json = require '../dom/json.coffee'

exports.dealWithChange = (element, val)->
    old = null
    console.log("Reloading from state box")
    #
    # change what needs to be changed in the area.
    #
    element.params.parent.state = json.parse(val)
    
    element.params.cb(old)

    # re init the whole app with those changes.
    guiInit.init(element.params.parent)

exports.init = (params)->

  if params.parent.state.visibleGuiControls[params.key]
    element = draw.draw("<textarea class=\"#{params.key}\">", params.parent.container)

    (params.parent.renderState = ->
      element.val(json.stringify(params.parent.state)))()
      
    element.params = 
      parent: params.parent
      cb: (old)->
        params.callbacks[params.key](
          area: params.parent
          old: old
          key: params.key
        )

    element.css('width', params.parent.face.width())
    element.css('height', 130)

    element.change (event)->
      exports.dealWithChange(element, event.target.value)
    element

