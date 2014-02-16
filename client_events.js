var clientPinger = require('./client_pinger');
exports.process = function(event) {
    if (event.data === 'pong') {
        document.querySelector('#ping').innerHTML = new Date() - clientPinger.start + "ms";
        setTimeout(function() {
            clientPinger.ping(event.currentTarget);
        }, 1000);
    }
};
