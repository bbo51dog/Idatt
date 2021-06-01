import ../lexer/token
import node

type Parser = ref object
  tokens: seq[Token]
  root: AstRoot
  pos: int


proc parse*(tokens: seq[Token]): AstRoot

proc newParser(tokens: seq[Token]): Parser
proc readToken(parser: Parser): Token
proc peekToken(parser: Parser): Token
proc atEnd(parser: Parser): bool


proc parse*(tokens: seq[Token]): AstRoot =
  let parser = tokens.newParser
  parser.root

proc newParser(tokens: seq[Token]): Parser =
  new result
  result.tokens = tokens

proc readToken(parser: Parser): Token =
  result = parser.peekToken
  if not parser.atEnd:
    inc parser.pos

proc peekToken(parser: Parser): Token =
  if parser.tokens.len > parser.pos:
    parser.tokens[parser.pos]
  else:
    TokenType.EOF.newToken

proc atEnd(parser: Parser): bool =
  parser.peekToken.tokenType == TokenType.EOF
