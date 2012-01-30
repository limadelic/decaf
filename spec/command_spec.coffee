should = require 'should'
{ mixin_command } = require '../src/serializer'
{ Command } = require '../src/command'

describe 'the command structure', ->

  it 'haz id', ->

    new Command(['id']).id().should.equal 'id'


