{ GameOfLife } = require '../lib/game_of_life'

class exports.Game

  doTable: (@table) -> @report @expected_cells(), @new_game().evolve()

  new_game: -> new GameOfLife @cells()

  cells: -> row[0...@board_size()] for row in @table
  expected_cells: -> row[@board_size() + 1..] for row in @table

  report: (expected, actual) ->
    for row in [0...@table.length]
      for col in [0...@table[0].length]
        if not @is_result col then ''
        else @result row, col, expected, actual

  result: (row, col, expected, actual) ->
    col -= @board_size() + 1
    if expected[row][col] is actual[row][col]
    then 'pass'
    else 'fail'

  is_result: (col) -> col > @board_size()

  board_size: -> Math.floor(@table[0].length / 2)