net = require 'net'

class exports.Server

  start: (port) ->
    @server = net.createServer @listener
    @server.listen port

  listener: (socket) =>

    socket.write hello

    socket.on 'data', (data) ->
      if data.toString() is bye then do exit else process data

    process = (data) -> socket.write stuff

    exit = =>
      socket.destroy()
      @server.close()

  hello = 'Slim -- V0.3\n'
  bye = '000003:bye'
  stuff = '000054:[000001:000037:[000002:000010:import_0_0:000002:OK:]:]'
