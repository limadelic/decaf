exports.deserialize = (command) ->
  return if not is_surrounded_by_backets command
  command = command[1..command.length - 2]
  command = command.split ':'
  [command[1]]

is_surrounded_by_backets = (command) ->
  command?.length > 1 and
  command[0] is '[' and
  command[command.length - 1] is ']'