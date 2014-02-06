class exports.Buffer

  command_from: (@data) ->
    @short_command() or @long_command()

  short_command: ->
    return if @buffer?
    return unless @data.length - 7 is @length()
    @command()

  long_command: ->
    @first_piece() or @add_piece()
    @done()

  first_piece: ->
    return if @buffer?
    [@expected_length, @buffer] = [@length(), @command()]

  add_piece: -> @buffer += @data.toString()

  done: ->
    throw 'invalid command' if @buffer.length > @expected_length
    return unless @buffer.length is @expected_length
    try
      return @buffer
    finally
      @buffer = undefined

  length: -> Number @data[0..5].toString()
  command: -> @data[7..].toString()


