net = require 'net'
{ verify, spy } = require './spec_helper'
{ SlimChunkBuffer } = require '../src/slim_chunk_buffer'
describe 'decaf server', ->

  sut = new SlimChunkBuffer()

  it 'should merge message chunks', ->
    # sometimes the data sent from the SLIM client arrives in chunks
    sut.command_from new Buffer('000014:[slim c')
    sut.command_from(new Buffer('ommand]')).should.equal('[slim command]')

  it 'should merge message chunks even with umlauten', ->    
    # characters are encoded as utf-8 from the SLIM client
    # e.g. umlaut-a is encoded as two bytes 0xc3 and 0xa4
    sut.command_from new Buffer([0x30, 0x30, 0x30, 0x30, 0x30, 0x34, 0x3a, 0xc3, 0xa4]) # 000004:ä
    # now send second a umlaut and check the command
    expected_command = new Buffer([0xc3, 0xa4, 0xc3, 0xa4]).toString() # ää
    sut.command_from(new Buffer([0xc3, 0xa4])).should.equal expected_command


  it 'should throw an exception if it received too much data', ->
    e = "no excpetion"
    try
        sut.command_from new Buffer('000001:aa')
    catch e
    e.should.equal('invalid command')
    
