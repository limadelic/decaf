_ = require 'underscore'
{ serialize, deserialize } = require './serializer'

class exports.Processor

  constructor: (@socket) ->

  run: (commands) ->
    @response = []
    @process command for command in deserialize commands
    @socket.write serialize @response

  process: (@command) ->
    console.log @command
    try @reply do @[@operation()]
    catch e then @error console.log e + @command

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
    console.log sut
    property = sut[@property()]
    @exec sut, property

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

  exec: (sut, property) ->
    if _.isFunction property
    then property.apply sut, @args()
    else property

  decision_table: ['table', 'beginTable', 'endTable', 'execute', 'reset']

  find_sut: () ->
    console.log 'dude wheres my sut?' + @property()
    if @has_property @sut then @sut
    else if @sut.sut? and @has_property @sut.sut then @sut.sut
    #else if @has_set_property() then @find_sut()
    else if @property() in @decision_table then @sut
    else throw 'property not found ' + @property()

  has_property: (sut) =>
    @property() in _.functions(sut) or
    @property() in _.keys(sut)

  has_set_property: () ->
    console.log 'here'
    return false unless @property()[0..2] is 'set'
    true

  reply: (message) -> @response.push [@id(), message]
  error: (e) -> @reply "__EXCEPTION__:message:<<#{e}>>"

  new: (constructor, args) ->
    F = () -> constructor.apply @, args
    F.prototype = constructor.prototype
    new F()





