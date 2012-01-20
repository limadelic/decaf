should = require 'should'
serializer = require '../src/serializer'

describe 'command deserializer', ->

  it 'should expect command to be enclosed in brackets', ->

    should.equal undefined, serializer.deserialize()
    should.equal undefined, serializer.deserialize ''
    should.equal undefined, serializer.deserialize 'command'
    should.equal undefined, serializer.deserialize '[command'
    should.equal undefined, serializer.deserialize 'command]'

    verify serializer.deserialize('[command]')?