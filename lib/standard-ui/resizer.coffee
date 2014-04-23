
$ = require 'jquery';
ui = require 'jquery-ui';
draw = require '../dom/draw.coffee'
guiInit = require '../gui_builder.coffee'

# Size of the controls to add onto canvas size
BOTTOM_CONTROL_SIZE = 200
RIGHT_CONTROL_SIZE = 10

exports.setToMaximum = (element)->
  largest = Math.min((root = element.params.parent.rootElement).width() - RIGHT_CONTROL_SIZE, 
    (root.height() - BOTTOM_CONTROL_SIZE))

  # stop infinate loop
  if (element.params.parent['len'] != largest)
    element.val(largest)
    exports.dealWithChange(element, largest)

exports.dealWithChange = (element, val)->
    old = element.params.parent['len']
    element.params.parent['len'] = parseInt(val)
    element.params.cb(old)
    guiInit.init(element.params.parent)

# 
# parent must respond to the redraw method
exports.init = (params)->

  element = draw.draw("<input type=\"number\" class=\"resize\">", params.parent.container)

  elementMaximize = draw.draw("<div class=\"btn maximize-size ui-icon ui-icon-arrow-4-diag\"></div>", params.parent.container)

  element.val(params.parent['len'])
  element.css('width', 46)

  element.params = 
    parent: params.parent
    cb: (old)->
      params.callbacks[params.key](
        area: params.parent
        old: old
        key: params.key
      )

  elementMaximize.click ->
    exports.setToMaximum(element)

  element.change (event)->
    exports.dealWithChange(element, event.target.value)

  element