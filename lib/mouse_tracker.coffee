# This tracks mouse position

exports.mousePos =
  x: 0
  y: 0

exports.startListening = ->
  $("html").mousemove (e) ->
    raw =
      x: e.pageX # - domGet.worldOffset().left,
      y: e.pageY # - domGet.worldOffset().top
    
    # must be after.
    exports.mousePos = raw

    # notify others of mouse move.
