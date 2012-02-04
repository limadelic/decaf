should = require 'should'
{ mixin_command } = require '../src/serializer'
{ Command } = require '../src/command'

describe 'the command', ->

  it 'haz id', ->

    new Command(['id']).id().should.equal 'id'

  it 'expands symbols', ->

    command = new Command ['id', 'make', 'instance', '$class']
    command.expand_symbols class: 'TestFixture'
    command.clazz().should.equal 'TestFixture'

  it 'expands null arg', ->

    command = new Command ['id', 'call', 'scriptTableActor', 'method', '$NULL']
    command.expand_symbols NULL: 'null'
    command.args()[0].should.equal 'null'
