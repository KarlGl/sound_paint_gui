var clientPinger = require('./client_pinger');
var clientArea = require('./client_area');
exports.process = function(event) {
    switch (window.JSON.parse(event.data).type) {
        case 'pong':
            return clientPinger.pong(event);
        case 'area':
            return clientArea.newWorld(event);
    }
};
