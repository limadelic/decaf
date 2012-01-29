_ = require 'underscore'
{ serialize, deserialize } = require './serializer'

class exports.Processor

  constructor: (@socket) ->

  run: (commands) ->
    @response = []
    @process command for command in deserialize commands
    @socket.write serialize @response

  process: (@command) ->
    try @reply do @[@operation()]
    catch e then @error e

  modules: []
  import: () ->
    @modules.push require @module()
    'OK'

  make: () ->
    @expand_symbols()
    @sut = @new @Clazz(), @args()
    'OK'

  call: () ->
    sut = @find_sut()
    value = sut[@property()]

    if _.isFunction value then value.apply sut, @args()
    else if @is_setter then @set_property sut
    else value

  vars: {}
  callAndAssign: () ->
    var_name = '$' + @symbol()
    @command[2..2] = []
    @vars[var_name] = @call()

  id: () -> @command[0]
  operation: () -> @command[1]
  module: () -> @command[2]
  symbol: () -> @command[2]
  clazz: () -> @command[3]
  property: () -> @command[3]
  call_signature: () -> _.tail @command, 3
  args: () -> _.tail @command, 4

  expand_symbols: () -> @expand_symbol symbol, i for symbol, i in @call_signature()

  expand_symbol: (symbol, i) ->
    return unless _.has @vars, symbol
    @command[3 + i] = @vars[symbol]

  Clazz: () ->
    module = _.find @modules, (x) => _.has x, @clazz()
    module[@clazz()]

  decision_table: ['table', 'beginTable', 'endTable', 'execute', 'reset']

  find_sut: () =>
    if @property_of(@sut)? then @sut
    else if @sut.sut? and @property_of(@sut.sut)? then @sut.sut
    else if @is_setter = @is_set_property() then @find_sut()
    else if @property() in @decision_table then @sut
    else throw 'property not found ' + @property()

  property_of: (sut) => return property for property of sut when property is @property()

  is_setter: false
  is_set_property: () ->
    return false unless @property()[0..2] is 'set'
    @command[3] = @command[3][0].toLowerCase() + @command[3][4..]
    true

  set_property: (sut) ->
    sut[@property()] = @args()[0]
    @is_setter = false

  reply: (message) -> @response.push [@id(), message]
  error: (e) -> @reply "__EXCEPTION__:message:<<#{e}>>"

  new: (constructor, args) ->
    F = () -> constructor.apply @, args
    F.prototype = constructor.prototype
    new F()





