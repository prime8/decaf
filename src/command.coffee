_ = require 'underscore'

class exports.Command

  constructor: (@items) ->

  id: () -> @items[0]
  operation: () -> @items[1]
  module: () -> @items[2]
  clazz: () -> @items[3]
  property: () -> @items[3]
  call_signature: () -> _.tail @items, 3
  args: () -> _.tail @items, 4

  symbol: () ->
    result = @items[2]
    @items[2..2] = []
    result

  is_set_property: () ->
    return false unless @property()[0..2] is 'set'
    @items[3] = @property()[0].toLowerCase() + @property()[4..]
    true

  decision_table: ['table', 'beginTable', 'endTable', 'execute', 'reset']

  is_decision_table: () -> @property() in @decision_table

  expand_symbols: (@vars) ->
    @expand_symbol token, i for token, i in @call_signature()

  expand_symbol: (token, i) ->
    @items[3 + i] = token.replace ///\$#{bar}///, value for bar, value of @vars


