exports.deserialize = (@command) ->
  if has_brackets() then drop_brackets() else return

  item() for [1..length()]

item = () -> token length()

length = () -> parseInt token(6), 10

has_brackets = () ->
  @command?.length > 1 and
  @command[0] is '[' and
  @command[@command.length - 1] is ']'

drop_brackets = () -> @command = @command[1..@command.length - 2]

token = (length) ->
  result = @command[0..length - 1]
  @command = @command = @command[length + 1..@command.length - 1]
  result


