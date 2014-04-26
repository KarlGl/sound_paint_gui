`var i = 0
        var len = 1000
        var out = [];
        for (i=0; i<len; i++) {
          out[i] = { 
            x: i/len,
            y: (Math.sin(2 * Math.PI * (i/len)) + 1) / 2
          }
        }`

module.exports = {
    len: 300,
    blockSize: 0.02,
    playSlider: 0.09,
    bpm: 6,
    isPlaying: true,
    isLooping: false,

    visibleGuiControls: {
      isPlaying: true,
      isLooping: true,
      playSlider: true,
      gridIsSnap_x: true,
      gridIsShow_x: true,
      gridIsSnap_y: true,
      gridIsShow_y: true,
      bpm: true,
      len: true,
      stateInput: true
    },

    gridIsSnap_x: false,
    gridIsShow_x: false,
    gridIsSnap_y: true,
    gridIsShow_y: true,
    
    units: [
      {
      "x": 0.1,
      "y": 0.07749843267518128,
      "waveName": "sin"
      },
      {
        "x": 0.14,
        "y": 0.10154068089173789,
        "waveName": "sin"
      }
    ],
    tools: [
      {name: 'pen'} 
      {name: 'waveforms'}
    ],
    toolActive: 'pen',
    optionActive: 'sin',
    waveforms: [
      {
        name: 'sin',
        color: "#6a00ff"
        # to generate the points yourself
        points: out,
      },
      {
        name: 'sqr',
        color: "#0000ff"
        points: []
      },
    ]
  }