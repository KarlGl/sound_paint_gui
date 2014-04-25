# 
# A class who writes things to the DOM
#

$ = require 'jquery'
ui = require 'jquery-ui';

module.exports = (child, parent)->
  if (!parent?)
    parent = $('.sound-paint')
  c=$(child)
  parent.append(c)
  c

if (typeof(window) != 'undefined')
  window.jq = $