var clientArea = require('./client_area');
exports.blockSize = 1 / 20;
exports.makeBlock = function(pos) {
    if (pos.x < clientArea.areaSizes)
        clientArea.newBlock(this.genBlock(pos));
}
exports.genBlock = function(pos) {
    return {
        x: pos.x / clientArea.areaSizes,
        y: pos.y / clientArea.areaSizes,
        blockSize: exports.blockSize
    }
}
