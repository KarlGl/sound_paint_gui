var socketEvents = require('./socket_events');
exports.dispatch = function(ws) {
    console.log('websocket connection open');

    ws.on('message', function(data, flags) {
        console.log('GOT: ' + data);
        var resp = socketEvents.choose(data);
        console.log('SENT: ' + resp);
        ws.send(resp);
    });

    ws.on('close', function() {
        console.log('websocket connection close');
    });
};