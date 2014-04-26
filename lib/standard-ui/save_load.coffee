#
# The text area box for saving and loading and hacking area state.
#

exports.init = (area)->
  dealWithChange: (val)->
    old = null
    console.log("Reloading from state box")
    #
    # change what needs to be changed in the area.
    #
    area.state = area.app.json.parse(val)
    
    area.stateTextArea.params.cb(old)

    # re init the whole app with those changes.
    area.restartGUI()

  renderState: ->
    area.stateTextArea.val(area.app.json.stringify(area.state))

  init: (params)->
    if area.state.visibleGuiControls[params.key]

      element = area.app.draw("<textarea class=\"#{params.key}\">", area.container)
      
      area.stateTextArea = element

      this.renderState()
        
      element.params = 
        parent: area
        cb: (old)->
          params.callbacks[params.key](
            area: area
            old: old
            key: params.key
          )

      element.css('width', area.face.width())
      element.css('height', 130)

      element.change (event)=>
        this.dealWithChange(event.target.value)
      element

