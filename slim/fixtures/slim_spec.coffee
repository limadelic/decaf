class exports.Echo
  echo: (sound) -> sound

class exports.SlimSpec
  string: null
  echo: (@sound) -> @sound

class exports.TestQuery
  constructor: (@n) ->
  query: () -> [['n', i], ['2n', 2 * i]] for i in [1..@n]


