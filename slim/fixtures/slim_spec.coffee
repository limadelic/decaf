class exports.EchoFixture
  name: undefined
  echo: (sound) -> sound

class exports.TestSlim
  constructor: (@generation = 0, @sample = undefined) ->
    @string = @sample.string if @sample?
  string: null
  echo: (@sound) -> @sound
  createTestSlimWithString: (s) ->
    x = new TestSlim()
    x.string = s
    x
  toString: -> "TestSlim: #{@generation}, #{@string}"
  isSame: (other) -> @ is other
  stringFromOther: (other) -> other.string
  returnConstructorArg: -> @generation

class exports.TestQuery
  constructor: (@n) ->
  query: () -> [['n', i], ['2n', 2 * i]] for i in [1..@n]

class exports.NullFixture
  null: -> null
  blank: -> ''

class exports.SplitFixture
  constructor: (schema) ->
    @lines = schema.split ';'
  query: ->
    results = []
    for i in [0..@lines.length - 1]
      line = @lines[i].split ','
      results.push [[1, line[0]], [2, line[1]]]
    results



