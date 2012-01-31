_ = require 'underscore'
{ SlimHelperLibrary } = require './slim_helper_library'

class exports.Sut

  libraries: [ new SlimHelperLibrary @ ]

  constructor: (@modules, @command) ->
    @sut = if _.isString @command.clazz()
    then @new @Clazz(), @command.args()
    else @command.clazz()

  call: (@command) ->
    sut = @find_sut()
    value = sut[@command.property()]

    if _.isFunction value then value.apply sut, @command.args()
    else if @is_setter then @set_property sut
    else value

  Clazz: () ->
    @module = _.find @modules, (x) => _.has x, @command.clazz()
    @module[@command.clazz()]

  find_sut: () =>
    if @property_of(@sut)? then @sut
    else if @sut.sut? and @property_of(@sut.sut)? then @sut.sut
    else if @is_setter = @command.is_set_property() then @find_sut()
    else if @command.is_decision_table() then @sut
    else throw 'property not found ' + @command.property()

  property_of: (sut) =>
    return property for property of sut when property is @command.property()

  fixture: ->

  is_setter: false

  set_property: (sut) ->
    sut[@command.property()] = @command.args()[0]
    @is_setter = false

  new: (constructor, args) ->
    F = () -> constructor.apply @, args
    F.prototype = constructor.prototype
    new F()
