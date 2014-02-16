exports.init = function() {
    var host = location.origin.replace(/^http/, 'ws');
    return new window.WebSocket(host);
};
