exports.stringify = (string)->
  JSON.stringify(string, undefined, 2)

exports.parse = (string)->
  JSON.parse(string)