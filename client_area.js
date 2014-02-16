exports.blockSize = 30;
exports.draw = function(event) {
    var context = document.getElementById("area").getContext("2d");

    var units = window.JSON.parse(event.data).area.units;
    units.forEach(function(unit) {
        context.fillRect(unit.x * this.blockSize, unit.y * this.blockSize, this.blockSize, this.blockSize)
    }.bind(this))
};
