should = require 'should'
{ Serializer } = require '../src/serializer'

describe 'response deserializer', ->

  sut = new Serializer()

  it 'should serialize empty responses', ->
    sut.serialize([])
      .should.equal '[000000:]'