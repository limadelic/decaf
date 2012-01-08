{ stub, mock, verify } = require './common'

{ Server } = require '../src/server'

net = require 'net'

describe 'decaf server', ->

  start = (port) -> new Server().start port
  server = stub net.createServer()
  stub(net, 'createServer').returns server

  it 'should listen on given port', ->

    start 8080

    verify server.listen.calledWith 8080

