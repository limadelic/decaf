net = require 'net'

class exports.Server

  start: (port) ->
    @server = net.createServer @listen
    @server.listen port

  listen: (@socket) =>
    @socket.write @hello
    @socket.on 'data', @message

  message: (data) =>
    @data = data.toString()
    if @data is @bye then @exit() else @process()

  process: ->
    @socket.write @stuff

  exit: ->
    @socket.destroy()
    @server.close()

  hello: 'Slim -- V0.3\n'
  bye: '000003:bye'
  stuff: '000054:[000001:000037:[000002:000010:import_0_0:000002:OK:]:]'
