{ MasterMind } = require '../lib/master_mind'

class exports.Game

  doTable: (@table) ->
    game = new MasterMind @solution()
    @report (game.eval @colors turn for turn in @table[1..])

  solution: -> @colors @table[0]

  colors: (turn) -> ['red', 'red', 'blue', 'blue']
  expected_results: (turn) -> ['black', 'black', 'black', 'black']

  total_of_turns: -> 1 #@table.length - 1
  report_header: [['','','','','','']]
  turn_header: ['','','','','']

  report: (@results) -> @report_header.concat @report_turns()

  report_turns: ->
    [@turn_header.concat @report_turn()] #turn for turn in [0...@total_of_turns()]

  report_turn: (turn) -> ['pass', 'pass', 'pass', 'pass']
#    actual_results = @results[turn][0..]
#    report_peg expected_result, actual_results for expected_result in @expected_results turn
#
#  report_peg: -> 'pass'





