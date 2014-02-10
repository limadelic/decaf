net = require 'net'
{ stub, verify, spy } = require './spec_helper'
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

    sut.message '000003:bye'

    verify exit.called

  it 'should run slim commands', ->

    sut.processor = stub run: (command) ->

    sut.message new Buffer('000014:[slim command]')

    verify sut.processor.run.calledWith '[slim command]'
