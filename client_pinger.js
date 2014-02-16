exports.pingRate = 13000;

exports.ping = function(ws) {
	this.start = new Date();
	ws.send('ping');
};

exports.pong = function(event) {
	document.querySelector('#ping').innerHTML = new Date() - this.start + "ms";
	        setTimeout(function() {
	            this.ping(event.currentTarget);
	        }.bind(this), this.pingRate);
};