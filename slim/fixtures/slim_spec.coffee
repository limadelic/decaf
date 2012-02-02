class exports.Echo
  echo: (sound) -> sound

class exports.TestSlim
  constructor: (@generation = 0) ->
  string: null
  echo: (@sound) -> @sound
  createTestSlimWithString: (s) ->
    x = new TestSlim()
    x.string = s
    x
  toString: -> "TestSlim: #{@generation}, #{@string}"

class exports.TestQuery
  constructor: (@n) ->
  query: () -> [['n', i], ['2n', 2 * i]] for i in [1..@n]


