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
proc peekExpect(parser: Parser, tokenType: TokenType): bool

proc parseExpr(parser: Parser): Node
proc parseAdd(parser: Parser): Node

proc parse*(tokens: seq[Token]): AstRoot =
  let parser = tokens.newParser
  parser.root.add parser.parseExpr
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
  parser.peekExpect(TokenType.EOF)

proc peekExpect(parser: Parser, tokenType: TokenType): bool =
  parser.peekToken.tokenType == tokenType

proc parseExpr(parser: Parser): Node =
  parser.parseAdd

proc parseAdd(parser: Parser): Node =
  if parser.peekExpect(TokenType.Int):
    let left = NodeType.IntLiteral.newTerminalNode(parser.readToken.value)
    discard parser.peekExpect(TokenType.Add)
    discard parser.readToken
    if parser.peekExpect(TokenType.Int):
      let right = NodeType.IntLiteral.newTerminalNode(parser.readToken.value)
      return NodeType.Add.newNonTerminalNode(left, right)
