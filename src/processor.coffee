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
  method: () -> @command[3]

  process: (@command) -> @[@operation()]()

  modules: []
  import: () ->
    @modules.push require @module()
    @reply 'OK'

  Clazz: () =>
    module = _.find @modules, (module) => _.has module, @clazz()
    module[@clazz()]

  make: () ->
    @sut = new (@Clazz())()
    @reply 'OK'

  call: () ->
    method = @sut[@method()]

    @reply if _.isFunction method
    then method()
    else method

  reply: (message) -> @response.push [@id(), message]



