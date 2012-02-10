class exports.GameOfLife

  constructor: (@cells) ->
    @size = @cells.length

  evolve: ->
    for row in [0...@size]
      for col in [0...@size]
        @evolve_at row, col


  evolve_at: (@row, @col, neighbors = @neighbors()) ->
    next = @cells[@row][@col]
    next = '0' unless 1 < neighbors < 4
    next = 'X' if neighbors is 3
    next

  is_alive: (x, y) -> @cells[x]?[y] is 'X'

  neighbors: -> ('X' for [x, y] in @vicinity() when @is_alive x, y).length

  vicinity: ->
    [@row + x, @col + y] for [x, y] in [
      [-1, -1], [0, -1], [1, -1],
      [-1,  0],          [1,  0],
      [-1,  1], [0,  1], [1,  1]
    ]

