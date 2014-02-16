exports.ping = function(ws) {
	this.start = new Date();
	ws.send('ping');
};