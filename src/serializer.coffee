########## Deserialize

exports.deserialize = deserialize = (command) ->
  new Deserializer().deserialize command

class Deserializer

  deserialize: (@command) ->
    return unless @is_deserializable()
    @item() for [1..@length()]

  item: () ->
    item = @token @length()
    deserialize(item) or item

  length: () -> parseInt @token(6), 10

  token: (length) ->
    result = @command[0..length - 1]
    @command = @command[length + 1..]
    result

  is_deserializable: () ->
    @command?.length > 1 and
    @command[0] is '[' and
    @command[@command.length - 1] is ']' and
    (@command = @command[1..@command.length - 2])

########## Serialize

exports.serialize = serialize = (response) ->
  new Serializer().serialize response

class Serializer

  serialize: (items) ->
    '[' + @length(items) + ':' + @list(items) + ']'

  list: (items) -> @string (
    @item item for item in items
  )

  item: (item) -> "#{@length item}:#{item}:"

  length: (length) ->
    length = length.length.toString()
    zeroes = @string (0 for [1..6 - length.length])
    zeroes + length

  string: (array) -> array.join ''

