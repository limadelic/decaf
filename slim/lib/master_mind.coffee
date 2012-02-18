class exports.MasterMind

  score: (@guess, @solution) -> @blacks().concat @rest()

  blacks: ->
    for i in [0..3] when @guess[i] is @solution[i]
      @match i
      'black'

  rest: ->
    for i in [0..3] when @guess[i] isnt 'matched'
      if @guess[i] in @solution
        @match i
        'white'
      else 'transparent'

  match: (i) ->
    guessed = @solution.indexOf @guess[i]
    @solution[guessed] = 'match'
    @guess[i] = 'match'
