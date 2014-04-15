var clientSoundPlayer = require('./client_sound_player');
var clientArea = require('./client_area');
var clientBlockMaker = require('./client_block_maker');
exports.mousePos = {
    x: 0,
    y: 0
};
exports.startListening = function() {
    $('html').mousemove(function(e) {
        clientSoundPlayer.
        var raw = {
            x: e.pageX, // - domGet.worldOffset().left,
            y: e.pageY // - domGet.worldOffset().top
        };
        // must be before.
        clientSoundPlayer.moved(exports.mousePos, raw);
        // must be after.
        exports.mousePos = raw;
    });
    $('html').mousedown(function(e) {
        if (exports.mousePos.y > clientArea.areaSizes) {
            $('html').css('cursor', 'help');
            clientSoundPlayer.play(exports.mousePos);
        } else if (exports.mousePos.y < clientArea.areaSizes) {
            $('html').css('cursor', 'alias');
            clientBlockMaker.makeBlock(exports.mousePos);
        }
    });
    $('html').mouseup(function(e) {
        $('html').css('cursor', 'default');
        clientSoundPlayer.killFuns.forEach(function(f) {
            f();
        });
        clientSoundPlayer.killFuns = [];
    });
}
