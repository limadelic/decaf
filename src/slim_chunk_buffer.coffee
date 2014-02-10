fs = require 'fs'

class exports.SlimChunkBuffer

  command_from: (@data) ->
    @add_chunk()
    @done()

  add_chunk: ->
    if not @buffer
      @buffer = @data
    else
      @buffer = Buffer.concat([@buffer, @data])

  done: ->
    throw 'invalid command' if @buffer.length > @expected_length()
    return unless @buffer.length is @expected_length()
    try
      return @command(@buffer)
    finally
      @buffer = undefined

  is_complete: ->
      # always check data length on buffer, not on string
      # the expected length refers to the length in bytes
      # a char which is encoded as 2 bytes in utf-8 would only count one
      @buffer.length == expected_length()
     
  expected_length: ->
      # expected length is the length of the initial length specifiction
      # of six bytes plus one for the colon plus the expected net load 
      7 + Number @buffer[0..5].toString()
      
  command: -> @buffer[7..].toString()