{ MasterMind } = require '../lib/master_mind'

class exports.Game

  doTable: (table) -> @report @play table

  play: (table) ->
    @board = new Board table
    @board.turns (t) => @play_turn t

  play_turn: (t) -> new MasterMind().
    rate @board.guess(t), @board.solution()

  report: (@results) ->
    @report_header.concat @board.turns (t) =>
      @turn_header.concat @report_turn t

  report_turn: (turn) ->
    results = @results[turn - 1][0..]
    @report_result result, results for result in @board.results turn

  report_result: (result, results) ->
    i = results.indexOf result
    if i is -1 then 'fail'
    else
      results[i] = 'matched'
      'pass'

  report_header: [['','','','','','']]
  turn_header: ['','','','','']


class Board

  constructor: (@table) ->

  solution: -> @guess 0

  guess: (turn) -> @colors @table[turn][1..4]
  results: (turn) -> @colors @table[turn][5..]

  colors: (cells) -> cell.match(@color)?[1] for cell in cells
  color: /.*class="(.*)".*/

  total_of_turns: -> @table.length - 1
  turns: (action) -> action turn for turn in [1..@total_of_turns()]









