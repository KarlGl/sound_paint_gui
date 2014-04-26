module.exports = {
    len: 300,
    blockSize: 0.02,
    playSlider: 0.09,
    bpm: 6,
    isPlaying: false,
    isLooping: true,

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
      # {x: 0.25, y: 0.1},
      # {x: 0.5, y: 0.2},
      # {x: 0.75, y: 0.1},
    ],
    tools: [
      {name: 'pen'} 
      {name: 'waveforms'}
    ],
    toolActive: 'pen',
    optionActive: 'sqr',
    waveforms: [
      {
        name: 'sin',
        color: "#6a00ff"
      },
      {
        name: 'sqr',
        color: "#0000ff"
      },
    ]
  }