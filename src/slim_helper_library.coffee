class exports.SlimHelperLibrary

  default_actor: "scriptTableActor"

  constructor: (@sut = null) ->

  fixtures: []

  fixture: -> @sut.suts[@default_actor]
  pushFixture: -> @fixtures.push @fixture()
  popFixture: -> @sut.suts[@default_actor] = @fixtures.pop




