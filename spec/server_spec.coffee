net = require 'net'
{ stub, verify } = require './common'
{ Server } = require '../src/server'

describe 'decaf server', ->

  sut = new Server()

  it 'should listen on given port', ->

    server = stub listen: ->
    stub(net, 'createServer').returns server

    sut.start 8080

    verify server.listen.calledWith 8080

  it 'should greet slim with the supported version', ->

    socket = stub
      write: ->
      on: ->

    sut.listen socket

    verify socket.write.calledWith sut.hello

  it 'should exit when slim says bye', ->

    exit = stub sut, 'exit'

    sut.message sut.bye

    verify exit.called

  it 'should process slim commands', ->

    process = stub sut, 'process'

    sut.message 'slim command'

    verify process.called


