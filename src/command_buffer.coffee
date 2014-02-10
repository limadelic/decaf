class exports.CommandBuffer

  command_from: (data) ->

    @buffer =
      if not @buffer? then data
      else Buffer.concat [@buffer, data]

    @done()

  done: ->
    throw 'invalid command' if @overflow()
    return unless @is_done()
    try return @command()
    finally @buffer = undefined

  is_done: -> @buffer.length is @expected_length()
  overflow: -> @buffer.length > @expected_length()
  expected_length: -> 7 + Number @buffer[0..5].toString()
  command: -> @buffer[7..].toString()