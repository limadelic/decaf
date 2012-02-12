{ GameOfLife } = require '../lib/game_of_life'

class exports.Game

  doTable: (table) -> @report @play table

  play: (table) ->
    @board = new Board table
    new GameOfLife().evolve @board.cells

  report: (cells) -> new Report().
    generate @board, cells

class Report

  generate: (@board, @cells) ->
    for row in [0...@board.row_count]
      for col in [0...@board.col_count]
        if not @is_result col then ''
        else @assert_cell row, col

  assert_cell: (row, col) ->
    col -= @board.size + 1
    if @cells[row][col] is @board.expected_cells[row][col]
    then 'pass'
    else 'fail'

  is_result: (col) -> col > @board.size

class Board

  constructor: (@table) ->
    @size = Math.floor(@table[0].length / 2)
    @cells = (row[0...@size] for row in @table)
    @expected_cells = (row[@size + 1..] for row in @table)
    @row_count = @table.length
    @col_count = @table[0].length
