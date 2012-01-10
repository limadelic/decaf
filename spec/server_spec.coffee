net = require 'net'
{ spy, stub, mock, verify } = require './common'
{ Server } = require '../src/server'

describe 'decaf server', ->

  start = (port) -> new Server().start port

  it 'should listen on given port', ->

    server = stub listen: ->
    stub(net, 'createServer').returns server

    start 8080

    verify server.listen.calledWith 8080

  listen = (socket) -> new Server().listener socket

  it 'should greet slim with the supported version', ->

    socket = stub
      write: ->
      on: ->

    listen socket

    verify socket.write.calledWith 'Slim -- V0.3\n'



