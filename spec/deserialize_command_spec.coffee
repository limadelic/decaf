should = require 'should'
{ Serializer } = require '../src/serializer'
{ verify } = require './spec_helper'

describe 'command deserializer', ->

  sut = new Serializer()

  should_not_deserialize = (commands) ->
    should.equal undefined, sut.deserialize command for command in commands

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

    sut.deserialize('[000001:000005:hello]').
      should.eql ['hello']

  it 'should deserialize multiple elements', ->

    sut.deserialize('[000002:000004:good:000003:bye]').
      should.eql ['good', 'bye']

  it 'should deserialize nested elements', ->

    sut.deserialize('[000003:000004:good:000003:bye:000032:[000002:000004:blue:000003:sky]]').
      should.eql ['good', 'bye', [ 'blue', 'sky']]
