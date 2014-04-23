# common functions on positions.

_ = require 'lodash'
# 
# Test if an (x,y) point is in a bounding box.
#
exports.isInBox = (pos, box)->
  if (pos.x >= box.left) &&
  (pos.x <= box.right) &&
  (pos.y >= box.top) &&
  (pos.y <= box.bottom)
    exports.amountInBox(pos, box)

# it has to snap to the top left of the nearest cell of gridCellSize, starting at 0,0.
exports.snapToGrid = (pos, gridCellSize)->
  x: gridCellSize * Math.round(pos.x / gridCellSize)
  y: gridCellSize * Math.round(pos.y / gridCellSize)

exports.snapToGridFromEquation = (pos, equation)->
  getClosest = (n, closest=0)->
    if (equation(n) < pos)
      getClosest(n + 1, equation(n))
    else
      [n, closest]

  # the closest but always taking the lower. [1] is the result.
  trunc = getClosest(0)

  # Test if one higher is closer.
  oneOver = equation(trunc[0])

  if oneOver < 1 && Math.abs(oneOver - pos) < Math.abs(trunc[1] - pos)
    oneOver
  else
    trunc[1]


# is a position in an array of them
exports.isIn = (arr, pos)->
  _.some(arr, (item)->
    _.isEqual(pos, item)
  )

#
# how far (0 to 1) pos in in box.
# retruns a hash with x,y
#
exports.amountInBox = (pos, box)->
  inboxx = (pos.x - box.left) 
  inboxy = (pos.y - box.top) 

  x: inboxx / (box.right - box.left)
  y: 1 - (inboxy / (box.bottom - box.top))

# can remove
window.positionLib = exports
