class exports.GameOfLife

  evolve: (@cells) ->
    for row in [0...@cells.length]
      for col in [0...@cells.length]
        { @row, @col } = { row, col }

        @evolve_cell @cell(), @neighbors()

  evolve_cell: (cell, neighbors) ->
    cell = '0' unless 1 < neighbors < 4
    cell = 'X' if neighbors is 3
    cell

  cell: -> @cells[@row][@col]
  neighbors: -> new Hood().count @cells, @row, @col

class Hood

  count: (@cells, @row, @col) -> @neighbors().length

  is_alive: (x, y) -> @cells[x]?[y] is 'X'

  neighbors: -> 'X' for [x, y] in @vicinity() when @is_alive x, y

  vicinity: ->
    [@row + x, @col + y] for [x, y] in [
      [-1, -1], [0, -1], [1, -1],
      [-1,  0],          [1,  0],
      [-1,  1], [0,  1], [1,  1]
    ]


