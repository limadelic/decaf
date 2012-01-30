_ = require 'underscore'
{ serialize, deserialize } = require './serializer'
{ Command } = require './command'
{ Sut } = require './sut'

class exports.Processor

  modules: []
  vars: {}

  constructor: (@socket) ->

  run: (commands) ->
    @response = []
    @process new Command command for command in deserialize commands
    @socket.write serialize @response

  process: (@command) ->
    try @reply do @[@command.operation()]
    catch e then @error e

  import: () ->
    @modules.push require @command.module()
    'OK'

  make: () ->
    @command.expand_symbols @vars
    @sut = new Sut @modules, @command
    'OK'

  call: () -> @sut.call @command

  callAndAssign: () -> @vars[@command.symbol()] = @call()

  reply: (message) -> @response.push [@command.id(), message]
  error: (e) -> @reply "__EXCEPTION__:message:<<#{e}>>"




