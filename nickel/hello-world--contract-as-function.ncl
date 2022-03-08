# The goal of this test was to try to make a contract that is applied like a function.
# So doing `Foo {field=1}` instead of `{field=1} | Foo`, which I think is more readable.
# For example: if the value is a record of a few lines (or a bg one), I (the reader) know from the
# start what that record is supposed to be, what contract it's supposed to validate with.
#
# => It works \o/
# Drawbacks:
# - currently the reported contract is 'contr' instead of 'string.NonEmpty'
#   see: https://github.com/tweag/nickel/issues/95
# - contracts built to be a function are not composable:
#   * I can combine contracts then convert the combined contract to a function that applies the contracts when applied on a value.
#   * BUT! I cannot combine contract that were already converted to functions. :/

let make_contract_fn = fun contr value => (
  value | contr
) in
let NonEmptyF = make_contract_fn string.NonEmpty in

let hello | Str = "hello" in
let hello_world = hello ++ " world" in

NonEmptyF hello_world


# In vim, for basic highlighting, run:
# :syn keyword Keyword let in fun if then
# :syn match Operator /++/
# :syn match Operator /|/
# :syn match Operator /=>/
