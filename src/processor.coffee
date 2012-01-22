{ deserialize } = require './serializer'

class exports.Processor

  constructor: (@socket) ->

  run: (commands) ->
    @import command for command in deserialize commands

  import: (command) -> @send command[0], 'OK'

  send: (id, status) -> @socket.write @serialize id, status

  serialize: (id, status) ->
    "000054:[000001:000037:[000002:000010:#{id}:000002:#{status}:]:]"

  vars: []