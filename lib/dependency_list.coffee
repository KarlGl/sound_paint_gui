# 
# This file is just a glorified dependency list 
# and what to initialize each with.
#
# Order matters.

createDepenency = (key, instance, initializeWith=[])->
    key: key
    instance: instance
    initializeWith: initializeWith

module.exports = ->
  [
    createDepenency('guiBuilder', (require './sound_paint_gui.coffee'))
    createDepenency( 'draw', (require './dom/draw.coffee'))
    # from other project
    createDepenency('soundHelpers', (window.SPhelpers))
    createDepenency('defaultState', (require './defaults/default_state.coffee'))
    createDepenency('json', (require './dom/json.coffee'))
    createDepenency('rootElement', (require './dom/root_element.coffee'), ['app'])
    createDepenency('colors', (require './color_theme.coffee'), ['app'])
    createDepenency('gridEquations', (require './positions/grid_equations.coffee'), ['app'])
    createDepenency('toggleBtn', (require './dom/toggle_btn.coffee'), ['area'])
    # must be before the two below
    createDepenency('block', (require './block.coffee'), ['area'])
    createDepenency('areaUnits', (require './area_units.coffee'), ['area'])
    createDepenency('areaDraw', (require './area_draw.coffee'), ['area'])
    #
    createDepenency('saveLoad', (require './standard-ui/save_load.coffee'), ['area'])
    createDepenency('resizer', (require './standard-ui/resizer.coffee'), ['area'])
    createDepenency('exclusiveButton', (require './standard-ui/exclusive_button.coffee'), ['area'])
    createDepenency('link', (require './link.coffee'), ['area'])
    createDepenency('tools', (require './standard-ui/tools.coffee'), ['area'])
    createDepenency('mouseTracker', (require './mouse_tracker.coffee'), ['area'])
  ]