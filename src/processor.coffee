class exports.Processor

  constructor: (@socket) ->

  run: (command) -> @socket.write @stuff

  stuff: '000054:[000001:000037:[000002:000010:import_0_0:000002:OK:]:]'