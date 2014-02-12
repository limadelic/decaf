_ = require 'underscore'
{ Command } = require './command'

#========= Deserialize

exports.deserialize = deserialize = (command) ->
  new Deserializer().deserialize command

class Deserializer

  deserialize: (@command) ->
    return unless @is_deserializable()
    @item() for [1..@length()]

  item: ->
    item = @token @length()
    deserialize(item) or item

  length: -> parseInt @token(6), 10

  token: (length) ->
    result = @command[0..length - 1]
    @command = @command[length + 1..]
    result

  is_deserializable: ->
    @command?.length > 1 and
    @command[0] is '[' and
    @command[@command.length - 1] is ']' and
    (@command = @command[1..@command.length - 2])

#========= Serialize

exports.serialize = serialize = (response) ->
  new Serializer().serialize response

class Serializer

  serialize: (response) ->
    result = @serialize_list response
    "#{@bytes result}:#{result}"

  serialize_list: (items) ->
    "[#{@length items}:#{@join items}]"

  join: (items) -> _.map(items, @serialize_item).join ''

  serialize_item: (item) =>
    item = @serialize_list item if _.isArray item
    item = 'null' if item in [null, undefined]
    item = item.toString()

    "#{@length item}:#{item}:"

  bytes: (buffer) -> @pad Buffer.byteLength buffer, 'utf-8'
  length: (string) -> @pad string.length

  pad: (number) ->
    n = number.toString()
    zeroes = new Array(7 - n.length).join '0'
    zeroes + n