should = require 'should'
{ Serializer } = require '../src/serializer'

describe 'command deserializer', ->

  sut = new Serializer()

  should_not_deserialize = (commands) ->
    should.equal undefined, sut.deserialize command for command in commands

  verify = (command, result) ->
    sut.deserialize(command).should.eql result

  it 'should expect command to be enclosed in brackets', ->

    should_not_deserialize [
      undefined
      null
      ''
      'command'
      '[command'
      'command]'
    ]

  it 'should deserialize single element', ->

     verify '[000001:000005:hello:]', ['hello']

  it 'should deserialize multiple elements', ->

    verify '[000002:000004:good:000003:bye:]', ['good', 'bye']

  it 'should deserialize nested elements', ->

    verify '[000003:000004:good:000003:bye:000032:[000002:000004:blue:000003:sky:]:]',
      ['good', 'bye', [ 'blue', 'sky']]
