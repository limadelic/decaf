class exports.World

  constructor: (@cells) ->

  neighbors_count: (@row, @col) -> @neighbors().length

  neighbors: -> 'X' for [x, y] in @vicinity() when @is_alive x, y

  is_alive: (x, y) -> @cells[x]?[y] is 'X'

  vicinity: ->
    [@row + x, @col + y] for [x, y] in [
      [-1, -1], [0, -1], [1, -1],
      [-1,  0],          [1,  0],
      [-1,  1], [0,  1], [1,  1]
    ]