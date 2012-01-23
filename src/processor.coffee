{ serialize, deserialize } = require './serializer'

class exports.Processor

  constructor: (@socket) ->

  run: (commands) ->
    @import command for command in deserialize commands

  import: (command) -> @send [[command[0], 'OK']]

  send: (response) -> @socket.write serialize response
