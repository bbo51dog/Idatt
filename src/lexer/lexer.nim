import token

type Lexer* = ref object
  input: string
  tokens: seq[Token]

proc newLexer*(input: string): return type =
  new result
  result.input

proc tokenize*(lexer: Lexer): [Token] =
  # TODO
  lexer.tokens
