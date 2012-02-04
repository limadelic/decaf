_ = require 'underscore'
{ serialize, deserialize } = require './serializer'
{ Command } = require './command'
{ Sut } = require './sut'

class exports.Processor

  constructor: (@socket) ->
    @sut = new Sut()

  run: (commands) ->
    @response = []

    @process new Command command for command in deserialize commands

    @socket.write serialize @response

  process: (@command) ->
    try @reply do @[@command.operation()]
    catch e then @error e

  import: ->
    @sut.require @command
    'OK'

  make: ->
    @sut.make @command
    'OK'

  call: -> @sut.call @command

  callAndAssign: -> @sut.callAndAssign @command

  reply: (message) -> @response.push [@command.id(), message]
  error: (e) -> @reply "__EXCEPTION__:message:<<#{e}>>"




