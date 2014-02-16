exports.pingRate = 40000;

exports.ping = function(ws) {
	this.start = new Date();
	ws.send('ping');
};

exports.pong = function(event) {
	window.document.querySelector('#ping').innerHTML = new Date() - this.start + "ms";
	        window.setTimeout(function() {
	            this.ping(event.currentTarget);
	        }.bind(this), this.pingRate);
};