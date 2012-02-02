class exports.SlimHelperLibrary

  constructor: (@sut = null) ->
    @fixtures = []

  fixture: -> @sut.sut
  pushFixture: -> @fixtures.push @fixture()
  popFixture: -> @sut.sut = @fixtures.pop()




