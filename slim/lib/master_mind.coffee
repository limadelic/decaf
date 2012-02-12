class exports.MasterMind

  constructor: (@solution) ->

  rate: (@guess) ->
    @sol = @solution[0..]
    @blacks().concat @whites()

  blacks: ->
    for i in [0..3] when @guess[i] is @sol[i]
      @delete i, i
      'black'

  whites: ->
    for i in [0..3] when @guess[i] isnt 'matched'
      j = @sol.indexOf @guess[i]
      if j is -1 then 'transparent'
      else
        @delete i, j
        'white'

  delete: (i, j) ->
    @guess[i] = 'matched'
    @sol[j] = 'matched'
