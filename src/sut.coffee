_ = require 'underscore'
{ SlimHelperLibrary } = require './slim_helper_library'

class exports.Sut

  constructor: ->
    @modules = []
    @vars = {}
    @libraries = [ new SlimHelperLibrary @ ]

  require: (@command) -> @modules.push require @command.module()

  make: (@command) ->
    @command.expand_symbols @vars

    @sut = if _.isString @command.clazz()
    then @new @Clazz(), @command.args()
    else @command.clazz()

    @libraries.push @sut if @command.is_library()

  call: (@command) ->
    @command.expand_symbols @vars

    sut = @find_sut()
    value = sut[@command.property()]

    if _.isFunction value then value.apply sut, @command.args()
    else if @is_setter_value() then @set_property sut
    else value

  callAndAssign: (@command) -> @vars[@command.symbol()] = @call @command

  Clazz: ->
    @module = _.find @modules, (x) => _.has x, @command.clazz()
    @module[@command.clazz()]

  find_sut: ->
    if @property_of(@sut)? then @sut
    else if @sut.sut? and @property_of(@sut.sut)? then @sut.sut
    else if @is_setter = @command.is_set_property() then @find_sut()
    else if (library = @find_library())? then library
    else if @command.is_decision_table() then @sut
    else throw 'property not found ' + @command.property()

  find_library: ->
    _.find @libraries[0..].reverse(), (library) =>
        @property_of library

  property_of: (sut) =>
    return property for property of sut when property is @command.property()

  is_setter_value: -> @is_setter or @command.args().length is 1

  set_property: (sut) ->
    sut[@command.property()] = @command.args()[0]
    @is_setter = false
    undefined

  new: (constructor, args) ->
    F = () -> constructor.apply @, args
    F.prototype = constructor.prototype
    new F()
