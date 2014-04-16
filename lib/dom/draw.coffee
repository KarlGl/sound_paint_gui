$ = require '../../node_modules/jquery/dist/jquery'
exports.draw = (child, parent)->
  if (!parent?)
    parent = $('body')
  c=$(child)
  parent.append(c)
  c

if (typeof(window) != 'undefined')
  window.jq = $