{ MasterMind } = require '../lib/master_mind'

class exports.Game

  doTable: (@table) ->
    @play_game()
    @report_results()

  play_game: ->
    @game = new MasterMind @solution()
    @results = @every_turn (t) => @game.rate @guess t

  report_header: [['','','','','','']]
  turn_header: ['','','','','']

  report_results: ->
    @report_header.concat @every_turn (t) =>
      @turn_header.concat @report_turn t

  report_turn: (turn) ->
    results = @results[turn - 1][0..]
    @report_result result, results for result in @expected_results turn

  report_result: (result, results) ->
    i = results.indexOf result
    if i is -1 then 'fail'
    else
      results[i] = 'matched'
      'pass'

  solution: -> @guess 0
  guess: (turn) -> @colors @table[turn][1..4]
  expected_results: (turn) -> @colors @table[turn][5..]
  colors: (cells) -> cell.match(@color)?[1] for cell in cells
  color: /.*class="(.*)".*/

  every_turn: (action) -> action turn for turn in [1..@total_of_turns()]

  total_of_turns: -> @table.length - 1









