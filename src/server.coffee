net = require 'net'
{ Processor } = require './processor'
{ SlimChunkBuffer } = require './slim_chunk_buffer'

class exports.Server

  start: (port) ->
    @server = net.createServer @listen
    @server.listen port

  listen: (@socket) =>
    @processor = new Processor @socket
    @buffer = new SlimChunkBuffer
    @socket.write @hello
    @socket.on 'data', @message

  message: (data) =>
    return unless command = @buffer.command_from data

    if command is 'bye'
    then @exit()
    else @processor.run command

  exit: ->
    @socket.destroy()
    @server.close()

  hello: 'Slim -- V0.3\n'

