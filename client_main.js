var clientInit = require('./client_init');
var clientEvents = require('./client_events');
var clientPinger = require('./client_pinger');
var ws = clientInit.init();
ws.onopen = function(event) {
	clientPinger.ping(this);
};
ws.onmessage = function(event) {
    clientEvents.process(event);
};