{ serialize, deserialize } = require './serializer'

class exports.Processor

  constructor: (@socket) ->

  run: (commands) ->
    @process command for command in deserialize commands

  id: () -> @command[0]
  operation: () -> @command[1]

  process: (@command) -> @[@operation()]()

  imports: []
  import: () ->
    @imports[@id()] = require @command[2]
    @respond 'OK'

  make: () -> @respond 'OK'

  respond: (message) -> @send [[@id(), message]]
  send: (response) -> @socket.write serialize response


