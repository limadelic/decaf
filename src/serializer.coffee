exports.deserialize = (command) ->
  return if not is_surrounded_by_backets command
  command = chop command
  tokens = command.split ':'
  [tokens[1]]

is_surrounded_by_backets = (string) ->
  string?.length > 1 and
  string[0] is '[' and
  string[string.length - 1] is ']'

chop = (string, length = 1) ->
  string[length..string.length - length - 1]
