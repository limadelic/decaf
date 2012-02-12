{ GameOfLife } = require '../lib/game_of_life'

class exports.Game

  doTable: (table) -> @report @play table

  play: (table) ->
    @board = new Board table
    new GameOfLife().evolve @board.cells

  report: (cells) -> new Report().generate @board, cells

class Report

  generate: (@board, @cells) ->
    for row in [0...@board.row_count]
      for col in [0...@board.col_count]
        @generate_at row, col

  generate_at: (@row, @col) ->
    if @is_result()
      if @matches() then 'pass'
      else 'fail'
    else ''

  is_result: -> @col > @board.size

  matches: ->
    @align_column()
    @expected() is @actual()

  align_column: -> @col -= @board.size + 1
  expected: -> @board.expected_cells[@row][@col]
  actual: -> @cells[@row][@col]

class Board

  constructor: (table) ->
    @size = Math.floor(table[0].length / 2)
    @cells = (row[0...@size] for row in table)
    @expected_cells = (row[@size + 1..] for row in table)
    @row_count = table.length
    @col_count = table[0].length
