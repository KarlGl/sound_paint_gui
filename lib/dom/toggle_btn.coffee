# 
# A generic UI button
#
#require './draw.coffee'

size = 30

exports.init = (area)->
  init: (params)->
    btn = area.app.draw("<div id=\"#{params.id}\">#{params.inner}</div>", area.container)
    # btn.css('width', size)
    btn.css('height', size)
    btn.addClass('btn')

    set = (v)->
      if (area.state[params.key] != v)
        old = area.state[params.key]
        area.state[params.key] = v
        params.cb(old)
      if area.state[params.key]
        btn.addClass('btn-on')
        btn.css('background-color', area.app.colors.active)
      else 
        btn.addClass('btn-off')
        btn.css('background-color', area.app.colors.inactive)

    set(area.state[params.key])

    btn.click ->
      set(!area.state[params.key])

