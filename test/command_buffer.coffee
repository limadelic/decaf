{ CommandBuffer } = require '../src/command_buffer'

describe 'Command buffering', ->

  sut = new CommandBuffer()
  process = (command) -> sut.command_from new Buffer command

  it 'should merge message chunks', ->
    process '000014:[slim c'
    process 'ommand]'
    .should.equal '[slim command]'

  it 'should merge message chunks even with umlauten', ->
    process [0x30, 0x30, 0x30, 0x30, 0x30, 0x34, 0x3a, 0xc3, 0xa4] # 000004:ä
    process  [0xc3, 0xa4] # ä
    .should.equal new Buffer([0xc3, 0xa4, 0xc3, 0xa4]).toString() # ää

  it 'should throw an exception if it received too much data', ->
    e = undefined
    try process '000001:aa'
    catch e
    e.should.equal 'invalid command'