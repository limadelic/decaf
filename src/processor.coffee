class exports.Processor

  constructor: (@socket) ->

  run: (command) ->
    command = @deserialize command
    @import command

  deserialize: (command) -> ['import_0_0', 'import', '../slim/fixtures/calculator']

  import: (command) ->
    @vars[command[0]] = require command[2]
    @send command[0], 'OK'

  send: (id, status) -> @socket.write @serialize id, status

  serialize: (id, status) ->
    "000054:[000001:000037:[000002:000010:#{id}:000002:#{status}:]:]"

  vars: []