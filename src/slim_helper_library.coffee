class exports.SlimHelperLibrary

  ACTOR_INSTANCE_NAME: "scriptTableActor"

  constructor: (@executor = null) ->

  fixtures: []

  fixture: -> @executor.instance @ACTOR_INSTANCE_NAME
  pushFixture: -> @fixtures.push @fixture()
  popFixture: -> @executor.instance[@ACTOR_INSTANCE_NAME] = @fixtures.pop




