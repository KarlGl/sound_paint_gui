var clientTone = require('./client_tone');
var clientArea = require('./client_area');
exports.killFuns = [];

exports.moved = function(old, newPos) {
	
};

exports.play = function(pos) {
    exports.killFuns = clientArea.getBlocksFor(pos.x).reduce(function(rt, block) {
    		var kf = clientTone.playTone(block.y);
        return kf ? rt.concat([kf]) : rt;
    }, [])
}
