class exports.MasterMind

  score: (@guess, @solution) -> @blacks().concat @whites()

  blacks: ->
    for i in [0..3] when @guess[i] is @solution[i]
      @match i
      'black'

  whites: ->
    for i in [0..3] when @guess[i] isnt 'matched'
      j = @solution.indexOf @guess[i]
      if j is -1 then 'transparent'
      else
        @match i, j
        'white'

  match: (i, j = i) ->
    @guess[i] = 'matched'
    @solution[j] = 'matched'
