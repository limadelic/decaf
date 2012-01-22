should = require 'should'
{ Serializer } = require '../src/serializer'

describe 'response deserializer', ->

  sut = new Serializer()

  verify = (response, result) ->
    sut.serialize(response).should.equal result

  it 'should serialize empty responses', ->

    verify [], '[000000:]'

  it 'should serialize single item responses', ->

    verify ['hello'], '[000001:000005:hello:]'

  it 'should serialize simple list responses', ->

    verify ['good', 'bye'], '[000002:000004:good:000003:bye:]'
