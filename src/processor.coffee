{ serialize, deserialize } = require './serializer'

class exports.Processor

  vars: []

  constructor: (@socket) ->

  run: (commands) ->
    @import command for command in deserialize commands

  import: (@command) ->
    @vars[@id()] = require @command[2]
    @send [[@id(), @ok]]

  send: (response) -> @socket.write serialize response

  id: () -> @command[0]
  operation: () -> @command[1]
  ok: 'OK'

