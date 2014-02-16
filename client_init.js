var clientMouse = require('./client_mouse');
exports.init = function() {
    clientMouse.startListening();

    var host = location.origin.replace(/^http/, 'ws');
    return new window.WebSocket(host);
};
