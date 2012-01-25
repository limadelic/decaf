_ = require 'underscore'
{ serialize, deserialize } = require './serializer'

class exports.Processor

  constructor: (@socket) ->

  run: (commands) ->
    @process command for command in deserialize commands

  id: () -> @command[0]
  operation: () -> @command[1]
  module: () -> @command[2]
  clazz: () -> @command[3]

  process: (@command) -> @[@operation()]()

  modules: []
  import: () ->
    @modules.push require @module()
    @reply 'OK'

  Clazz: () =>
    module = _.find @modules, (module) => _.has module, @clazz()
    module[@clazz()]

  make: () ->
    @sut = new (do @Clazz)()
    @reply 'OK'

  reply: (message) -> @send [[@id(), message]]
  send: (response) -> @socket.write serialize response


