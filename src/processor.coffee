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
  property: () -> @command[3]
  args: () -> _.tail @command, 4

  process: (@command) -> @[@operation()]()

  modules: []
  import: () ->
    @modules.push require @module()
    @reply 'OK'

  make: () ->
    module = _.find @modules, (x) => _.has x, @clazz()
    @sut = new (module[@clazz()])()
    @reply 'OK'

  call: () ->
    property = @sut[@property()]

    @reply if _.isFunction property
    then property.apply @sut, @args()
    else property

  reply: (message) -> @response.push [@id(), message]



