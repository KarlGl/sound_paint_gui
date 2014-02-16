exports.choose = function(req) {
    var pack = function(type, dataRet) {
        var data = {
            type: type
        };
        if (data)
            data[type] = dataRet;
        return JSON.stringify(data);
    };
    switch (req) {
        case 'ping':
            return pack('pong');
        case 'area':
            return pack('area', {
                units: Array.apply(null, new Array(20))
                    .reduce(function(rt, val, i) {
                        return rt.concat({
                            x: i/20,
                            y: i/20,
                            blockSize: 1/20
                        });
                    }, [])
            });
    }
};
