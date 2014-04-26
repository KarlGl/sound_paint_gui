#
# The root element of the program, includes all areas and other elements in it.
#
exports.init = (app)->
  draw: ->
    rootElement = app.draw("<div class=\"sound-paint\"></div>", app.$('body'))
    rootElement.css('width', '100%')
    rootElement.css('height', '100%')
    rootElement