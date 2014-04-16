# 
# A class who writes things to the DOM
#

$ = require 'jquery'
ui = require 'jquery-ui';

exports.draw = (child, parent)->
  if (!parent?)
    parent = $('body')
  c=$(child)
  parent.append(c)
  c

if (typeof(window) != 'undefined')
  window.jq = $