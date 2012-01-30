should = require 'should'
{ mixin_command } = require '../src/serializer'
{ Command } = require '../src/command'

describe 'the command', ->

  it 'haz id', ->

    new Command(['id']).id().should.equal 'id'

  it 'expands symbols', ->

    command = new Command ['id', 'make', 'instance', '$classFixture']
    command.expand_symbols class: 'Test'
    command.clazz().should.equal 'TestFixture'
