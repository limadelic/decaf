exports.deserialize = (@command) ->
  if has_brackets() then drop_brackets() else return

  item() for [1..length()]

item = () ->
  length()
  result = @command[0..@length - 1]
  drop_item()
  result

has_brackets = () ->
  @command?.length > 1 and
  @command[0] is '[' and
  @command[@command.length - 1] is ']'

drop_brackets = () -> @command = @command[1..@command.length - 2]
drop_length = () ->  @command = @command[7..@command.length - 1]
drop_item = () -> @command = @command[@length + 1..@command.length - 1]

length = () ->
  @length = parseInt @command[0..6], 10
  drop_length()
  @length
