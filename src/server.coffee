net = require 'net'
{ Processor } = require './processor'

class exports.Server

  start: (port) ->
    @server = net.createServer @listen
    @server.listen port

  listen: (@socket) =>
    @processor = new Processor @socket
    @socket.write @hello
    @socket.on 'data', @message

  message: (data) =>
    command = @command_from data

    if command is 'bye'
    then @exit()
    else @processor.run command

  command_from: (data) -> data[7..].toString()

  exit: ->
    @socket.destroy()
    @server.close()

  hello: 'Slim -- V0.3\n'

