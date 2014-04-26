exports.init = (area)->

  lens = 
    point:
      w: 6
      h: 6
    canvas:
      w: area.state.len
      h: area.state.len
  color = area.app.colors.primary
  mouseX = 0
  mouseY = 0

  #Get mouse position
  getMouseXY = (e) ->
    mouseX = e.pageX
    mouseY = e.pageY
    mouseX = 0  if mouseX < 0
    mouseY = 0  if mouseY < 0
    mouseX = mouseX - canvasDiv.offset().left
    mouseY = mouseY - canvasDiv.offset().top
    true
  addPoint = ->
    point = {
      x: (mouseX / lens.canvas.w), 
      y: (mouseY / lens.canvas.h)
    }
    
    area.app.block.currentWaveform()?.points.push(point)
    area.app.saveLoad.renderState()
    
    drawPoint(point)

  drawPoint = (point)->
    area.waveformEditor.context.fillRect(
      (point.x * lens.canvas.w) - (lens.point.w / 2),
      (point.y * lens.canvas.h) - (lens.point.h / 2),
      lens.point.w,
      lens.point.h,
    )

  drawExistingPoints = ->
    area.app.block.currentWaveform()?.points.forEach (point)->
      drawPoint(point)

  area.waveformEditor = {}
  area.waveformEditor.face = canvasDiv = area.app.draw("<canvas class=\"waveform-editor\"></canvas><br/>", area.container)
    .attr('width', area.state.len)
    .attr('height', area.state.len)
  area.waveformEditor.context = context = canvasDiv[0].getContext("2d")
  context.fillStyle = color

  points = drawExistingPoints()

  canvasDiv.mousemove getMouseXY
  canvasDiv.click addPoint