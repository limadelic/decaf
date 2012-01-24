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
    @respond 'OK'

  make: () ->
    module = _.find @modules, (module) => module[@clazz()]
    @sut = module[@clazz()]()
    #console.log @sut['yay']
    @respond 'OK'

  respond: (message) -> @send [[@id(), message]]
  send: (response) -> @socket.write serialize response


