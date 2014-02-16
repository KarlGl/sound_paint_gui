var socketDispatcher = require('./socket_dispatcher');
var socketInit = require('./socket_init'),
    http = require('http'),
    express = require('express'),
    app = express(),
    port = process.env.PORT || 5000;

app.use(express.static(__dirname + '/'));

var server = http.createServer(app);
server.listen(port);
console.log('http server listening on %d', port);

var ws = socketInit.init(server);
ws.on('connection', function(ws) {
  socketDispatcher.dispatch(ws);
});
