_ = require 'underscore'
{ serialize, deserialize } = require './serializer'
{ Command } = require './command'

class exports.Processor

  constructor: (@socket) ->

  run: (commands) ->
    @response = []
    @process new Command command for command in deserialize commands
    @socket.write serialize @response

  process: (@command) ->
    try @reply do @[@command.operation()]
    catch e then @error e

  modules: []
  import: () ->
    @modules.push require @command.module()
    'OK'

  make: () ->
    @expand_symbols()
    @sut = @new @Clazz(), @command.args()
    'OK'

  call: () ->
    sut = @find_sut()
    value = sut[@command.property()]

    if _.isFunction value then value.apply sut, @command.args()
    else if @is_setter then @set_property sut
    else value

  vars: {}
  callAndAssign: () -> @vars[@command.symbol()] = @call()

  expand_symbols: () -> @expand_symbol symbol, i for symbol, i in @command.call_signature()

  expand_symbol: (symbol, i) ->
    return unless _.has @vars, symbol
    @command.expand_symbol 3 + i, @vars[symbol]

  Clazz: () ->
    module = _.find @modules, (x) => _.has x, @command.clazz()
    module[@command.clazz()]

  find_sut: () =>
    if @property_of(@sut)? then @sut
    else if @sut.sut? and @property_of(@sut.sut)? then @sut.sut
    else if @is_setter = @command.is_set_property() then @find_sut()
    else if @command.is_decision_table() then @sut
    else throw 'property not found ' + @command.property()

  property_of: (sut) =>
    return property for property of sut when property is @command.property()

  is_setter: false

  set_property: (sut) ->
    sut[@command.property()] = @command.args()[0]
    @is_setter = false

  reply: (message) -> @response.push [@command.id(), message]
  error: (e) -> @reply "__EXCEPTION__:message:<<#{e}>>"

  new: (constructor, args) ->
    F = () -> constructor.apply @, args
    F.prototype = constructor.prototype
    new F()





