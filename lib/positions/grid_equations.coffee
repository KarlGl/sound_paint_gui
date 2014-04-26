exports.init = (app)->
  -> {
      x: {
        get: (n)->
          1/16 * n
      } 
      y: {
        get: (n)->
          b=Math.pow(1.059463, n)
          app.soundHelpers.humanEar.freqToRange(27.5*b)
      }
    }