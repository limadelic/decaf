########## Deserialize

exports.deserialize = deserialize = (command) ->
  new Deserializer().deserialize command

class Deserializer

  deserialize: (@command) ->
    return unless @is_deserializable()
    @item() for [1..@length()]

  item: () ->
    item = @token @length()
    deserialize(item) or item

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

########## Serialize

exports.serialize = serialize = (response) ->
  result = new Serializer().serialize response
  length(result) + ':' + result

class Serializer

  serialize: (items) ->
    '[' + length(items) + ':' + @list(items) + ']'

  list: (items) -> string (@item item for item in items)

  item: (item) ->
    item = @serialize item if item instanceof Array
    item = 'null' if item in [null, undefined]
    item = item.toString()

    length(item) + ':' + item + ':'

length = (item) ->
  len = item.length.toString()
  zeroes = string (0 for [1..6 - len.length])
  zeroes + len

string = (array) -> array.join ''
