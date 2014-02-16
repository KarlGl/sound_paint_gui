exports.context = new window.webkitAudioContext();
exports.playTone = function(f) {
    if (!f) return;
    var osc = {};
    osc.raw = this.context.createOscillator();
    osc.raw.connect(this.context.destination);
    osc.raw.noteOn(0);

    osc.raw.frequency.value = exports.toHumanFreq(f);

    return function() {
        osc.raw.disconnect();
    };

};

// from 0 to 1.
exports.toHumanFreq = function(f) {
    return f * 4985 + 15;
};
