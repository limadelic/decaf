_ = require 'underscore'
{ Command } = require './command'

#========= Deserialize

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

#========= Serialize

exports.serialize = serialize = (response) ->
  result = new Serializer().serialize response
  formatted_length(Buffer.byteLength(result, 'utf-8')) + ':' + result

class Serializer

  serialize: (items) ->
    '[' + formatted_length(items.length) + ':' + @list(items) + ']'

  list: (items) -> string (@item item for item in items)

  item: (item) ->
    item = @serialize item if _.isArray item
    item = 'null' if item in [null, undefined]
    item = item.toString()

    formatted_length(item.length) + ':' + item + ':'

formatted_length = (item) ->
  len = item.toString()
  zeroes = string (0 for [1..6 - len.length])
  zeroes + len

string = (array) -> array.join ''
