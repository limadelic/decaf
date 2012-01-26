should = require 'should'
{ Processor } = require '../src/processor'

describe 'calling methods', ->

  decaf = new Processor()
  decaf.command = [
    'id', 'call', 'actor', 'methodName', 'arg1', 'arg2'
  ]

  it 'should get method name from commands', ->

    decaf.property().should.equal 'methodName'

  it 'should get args from commands', ->

    decaf.args().should.eql ['arg1', 'arg2']

