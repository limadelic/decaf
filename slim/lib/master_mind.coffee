class exports.MasterMind

  constructor: (@solution) ->

  rate: (@guess) ->
    @copy_solution_and_guess()
    @blacks().concat @whites()

  blacks: ->
    for i in [0..3] when @guess[i] is @solution[i]
      @match i
      'black'

  whites: ->
    for i in [0..3] when @guess_copy[i] isnt 'matched'
      j = @solution_copy.indexOf @guess_copy[i]
      if j is -1 then 'transparent'
      else
        @match i, j
        'white'

  match: (i, j = i) ->
    @guess_copy[i] = 'matched'
    @solution_copy[j] = 'matched'

  copy_solution_and_guess: ->
    @solution_copy = @solution[0..]
    @guess_copy = @guess[0..]
