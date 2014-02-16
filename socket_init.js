var WebSocketServer = require('ws').Server

exports.init = function (webserver) {
	console.log('websocket server created');
	return new WebSocketServer({server: webserver});
};

