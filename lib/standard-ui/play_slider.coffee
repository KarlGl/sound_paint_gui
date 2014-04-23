# 
# The slider to select the range to play.
#

slider = require '../dom/slider.coffee'
exports.init = (area, callbacks)->
  key = "playSlider"
  slider.init
      parent: area,
      key: key
    , callbacks


