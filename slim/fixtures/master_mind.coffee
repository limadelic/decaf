{ MasterMind } = require '../lib/master_mind'

class exports.Game

  doTable: (table) -> @report @play table

  play: (table) ->
    @board = new Board table
    @board.turns (t) => @play_turn t

  play_turn: (t) -> new MasterMind().
    score @board.guess(t), @board.solution()

  report: (scores) -> new Report().
    generate @board, scores

class Report

  generate: (@board, @scores) ->
    @report_header.concat @board.turns (t) =>
      @turn_header.concat @generate_turn t

  generate_turn: (@turn) ->
    @generate_score score for score in @expected_turn_scores()

  generate_score: (score) ->
    i = @turn_scores().indexOf score
    if i is -1 then 'fail'
    else
      @turn_scores()[i] = 'matched'
      'pass'

  expected_turn_scores: -> @board.scores @turn
  turn_scores: -> @scores[@turn - 1]

  report_header: [['','','','','','']]
  turn_header: ['','','','','']

class Board

  constructor: (@table) ->

  solution: -> @guess 0

  guess: (turn) -> @colors @table[turn][1..4]
  scores: (turn) -> @colors @table[turn][5..]

  colors: (cells) -> cell.match(@color)?[1] for cell in cells
  color: /.*class="(.*)".*/

  turns_count: -> @table.length - 1
  turns: (action) -> action turn for turn in [1..@turns_count()]









