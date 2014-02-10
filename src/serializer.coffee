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
  serializer = new Serializer()
  content = serializer.serialize response
  formatted_length(serializer.total_length) + ':' + content

class Serializer
  
  constructor: ->
    @total_length = 0
      
  serialize: (items) ->
    console.log JSON.stringify items
    @total_length += 9 # is always [######:<content>] = 1 bracket + 6 times number + colon + bracket  
    content = '[' + formatted_length(items.length) + ':' + @list(items) + ']'

  list: (items) -> string (@item item for item in items)

  item: (item) ->
    is_item_array = _.isArray item
    item = @serialize item if is_item_array
    item = 'null' if item in [null, undefined]
    item = item.toString()
    length = Buffer.byteLength(item, 'utf-8')
    @total_length += (if is_item_array then 0 else length ) + 2 + 6
    console.log "T:" + @total_length + ", " + item
    formatted_length(length) + ':' + item + ':'
    

formatted_length = (length) ->
  len = length.toString()
  zeroes = string (0 for [1..6 - len.length])
  zeroes + len

string = (array) -> array.join ''
