should = require 'should'
{ Command } = require '../src/command'

describe 'calling methods', ->

  command = new Command [
    'id', 'call', 'actor', 'methodName', 'arg1', 'arg2'
  ]

  it 'should get args from commands', ->

    command.args().should.eql ['arg1', 'arg2']

