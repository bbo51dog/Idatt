type
  TokenType* {.pure.} = enum
    Number
    Add
    Sub
    Mul
    Div

  Token* = ref object
    tokenType: TokenType
