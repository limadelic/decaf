_ = require 'underscore'
{ serialize, deserialize } = require './serializer'

class exports.Processor

  constructor: (@socket) ->

  run: (commands) ->
    @response = []
    @process command for command in deserialize commands
    @socket.write serialize @response

  id: () -> @command[0]
  operation: () -> @command[1]
  module: () -> @command[2]
  symbol: () -> @pull_command 2
  clazz: () -> @command[3]
  property: () -> @command[3]
  args: () -> _.tail @command, 4

  process: (@command) -> @[@operation()]()

  modules: []
  import: () ->
    @modules.push require @module()
    @reply 'OK'

  make: () ->
    @sut = @new @Clazz(), @args()
    @reply 'OK'

  Clazz: () ->
    module = _.find @modules, (x) => _.has x, @clazz()
    module[@clazz()]

  call: () ->
    property = @sut[@property()]

    @reply if _.isFunction property
    then property.apply @sut, @args()
    else property

  symbols: {}
  callAndAssign: () -> @symbols[@symbol()] = @call()

  reply: (message) ->
    @response.push [@id(), message]
    message

  pull_command: (i) ->
    command = @command[i]
    @command[i..i] = []
    command

  new: (constructor, args) ->
    F = () -> constructor.apply @, args
    F.prototype = constructor.prototype
    new F()





