exports.worlds = [];
exports.areaSizes = 300;

exports.redraw = function() {
    var context = window.document
        .getElementById("area").getContext("2d");
    var draw = function(context, unit) {
        context.fillRect(unit.x * this.areaSizes, unit.y * this.areaSizes, unit.blockSize * this.areaSizes, unit.blockSize * this.areaSizes)
    };

    exports.worlds.forEach(function(area) {
        area.units.forEach(function(unit) {
            draw.bind(this)(context, unit);
        }.bind(this));
    }.bind(this))
}

exports.newBlock = function(unit) {
    if (exports.worlds.length) {
        exports.worlds[0].units.push(unit);
        exports.redraw();
    }
}

exports.getBlockBB = function(block) {
    var left = block.x * this.areaSizes;
    return {
        left: left,
        right: left + block.blockSize * this.areaSizes
    };
}

// Left side is allowed to be equal to, right is not.
exports.getBlocksFor = function(pos) {
    return (exports.worlds.length &&
        pos < exports.areaSizes) ?

    exports.worlds[0].units.filter(function(unit) {
        return (pos >= exports.getBlockBB(unit).left && pos < exports.getBlockBB(unit).right);
    }) : [];
}

exports.newWorld = function(event) {
    exports.worlds.push(window.JSON.parse(event.data)
        .area);
    exports.redraw();
};
