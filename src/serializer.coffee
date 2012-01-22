class exports.Serializer

  deserialize: (@command) ->
    return unless @is_deserializable()
    @item() for [1..@length()]

  list: (items) -> new Serializer().deserialize items

  item: () ->
    item = @token @length()
    @list(item) or item

  length: () -> parseInt @token(6), 10

  token: (length) ->
    result = @command[0..length - 1]
    @command = @command[length + 1..]
    result

  is_deserializable: () ->
    @command?.length > 1 and
    @command[0] is '[' and
    @command[@command.length - 1] is ']' and
    (@command = @command[1..@command.length - 2])

  serialize: (@response) ->
    "[#{@length_to_s response.length}:#{@response_to_s()}]"

  response_to_s: () -> @string_of (
    @item_to_s item for item in @response
  )

  item_to_s: (item) -> "#{@length_to_s item.length}:#{item}:"

  length_to_s: (length) ->
    length = length.toString()
    zeroes = @string_of (0 for [1..6 - length.length])
    zeroes + length

  string_of: (array) -> array.join ''