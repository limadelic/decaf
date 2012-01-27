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
  clazz: () -> @command[3]
  property: () => @sut[@command[3]]
  args: () -> _.tail @command, 4

  process: (@command) ->
    try @[@operation()]()
    catch e then @error e

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
    @reply if _.isFunction @property()
    then @property().apply @sut, @args()
    else @property()

  callAndAssign: () ->
    @command[2..2] = []
    @call()

  reply: (message) -> @response.push [@id(), message]
  error: (e) -> @reply "__EXCEPTION__:message:<<#{e}>>"

  new: (constructor, args) ->
    F = () -> constructor.apply @, args
    F.prototype = constructor.prototype
    new F()





