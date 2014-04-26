
# Size of the controls to add onto canvas size
BOTTOM_CONTROL_SIZE = 310
RIGHT_CONTROL_SIZE = 20

exports.init = (area)->
    out = 
      setToMaximum: ()->
        # snap to max len at the start?
        # can't be in the area init, that can be called seperately to this.
        if (area.state.visibleGuiControls.len)
          largest = Math.min((root = area.rootElement).width() - RIGHT_CONTROL_SIZE, 
            (root.height() - BOTTOM_CONTROL_SIZE))

          # stop infinate loop, only snap if not current len.
          if (area.state['len'] != largest)
            area.resizerElement.val(largest)
            this.dealWithChange(largest)
        this

      dealWithChange: (val)->
        old = area.state['len']
        area.state['len'] = parseInt(val)
        area.resizerElement.params.cb(old)

        area.restartGUI()

      # 
      # parent must respond to the redraw method
      init: (params)->
        element = area.app.draw("<input type=\"number\" class=\"resize\">", area.container)
        area.resizerElement = element


        elementMaximize = area.app.draw("<div class=\"btn maximize-size ui-icon ui-icon-arrow-4-diag\"></div>", area.container)

        element.val(area.state['len'])
        element.css('width', 46)

        element.params = 
          parent: area
          cb: (old)->
            params.callbacks[params.key](
              area: area
              old: old
              key: params.key
            )

        # call right away
        # out.setToMaximum()

        elementMaximize.click =>
          this.setToMaximum()

        element.change (event)=>
          this.dealWithChange(event.target.value)


        element
