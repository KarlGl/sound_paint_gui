var clientPinger = require('./client_pinger');
exports.process = function(event) {
    if (event.data === 'pong') {
        clientPinger.pong(event);
    }
};
