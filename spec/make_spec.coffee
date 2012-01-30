should = require 'should'
{ Processor } = require '../src/processor'
{ verify, stub } = require './spec_helper'
{ Calculator } = require '../slim/fixtures/calculator'
{ Command } = require '../src/command'

describe 'making suts', ->

  decaf = new Processor()
  stub decaf, 'reply'
  sut = () -> decaf.sut.sut

  it 'should make a Calculator', ->

    decaf.modules = [ require '../slim/fixtures/calculator' ]
    decaf.process new Command [ '42', 'make', 'stuff', 'Calculator' ]

    verify sut() instanceof Calculator

  it 'expands object into symbol', ->

    command = new Command ['id', 'make', 'instance', '$cached']
    command.expand_symbols cached: { name: 'lola' }
    command.clazz().name.should.equal 'lola'

  it 'should reuse an object in a symbol', ->

    decaf.vars['cached'] = { name: 'lola' }
    decaf.process new Command [ '42', 'make', 'stuff', '$cached' ]

    sut().name.should.equal 'lola'


