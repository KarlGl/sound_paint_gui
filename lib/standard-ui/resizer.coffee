
$ = require 'jquery';
ui = require 'jquery-ui';
draw = require '../dom/draw.coffee'
guiInit = require '../gui_builder.coffee'

# 
# parent must respond to the redraw method
exports.init = (params)->

  # Size of the bottom controls
  BOTTOM_CONTROL_SIZE = 100

  element = draw.draw("<input type=\"number\" class=\"resize\">", params.parent.container)

  elementMaximize = draw.draw("<div class=\"btn maximize-size ui-icon ui-icon-arrow-4-diag\"></div>", params.parent.container)

  element.val(params.parent['len'])
  element.css('width', 46)

  cb = (old)->
    params.callbacks[params.key](
      area: params.parent
      old: old
      key: params.key
    )

  dealWithChange = (val)->
    old = params.parent['len']
    params.parent['len'] = parseInt(val)
    cb(old)
    guiInit.init(params.parent)

  setToMaximum = ->
    largest = Math.min((root = params.parent.rootElement).width(), 
      (root.height() - BOTTOM_CONTROL_SIZE))

    # stop infinate loop
    if (params.parent['len'] != largest)
      element.val(largest)
      dealWithChange(largest)
    
  elementMaximize.click ->
    setToMaximum(event.target.value)

  element.change (event)->
    dealWithChange()

  setToMaximum()

  element