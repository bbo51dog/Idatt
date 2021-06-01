import unittest
import lexer/lexer, lexer/token

proc assertToken(expect: Token, passed: Token) =
  doAssert expect[] == passed[], $expect.tokenType & "(value=\"" &
      expect.value & "\") expected, " & $passed.tokenType & "(value=\"" &
      passed.value & "\") passed"

suite "Lexer":
  test "tokenize calculation":
    let tokens = "(123 + 456 ) * 7".tokenizeString
    let expectTokens = [
      TokenType.LParen.newToken,
      TokenType.Int.newToken($123),
      TokenType.Add.newToken,
      TokenType.Int.newToken($456),
      TokenType.RParen.newToken,
      TokenType.Mul.newToken,
      TokenType.Int.newToken($7),
      TokenType.EOF.newToken,
    ]
    for i, token in tokens:
      assertToken(expectTokens[i], token)

  test "tokenize statements":
    let tokens = """
    let foo = 1 + 2;
    fun bar() {
      return "bar";
    }
    """.tokenizeString
    let expectTokens = [
      TokenType.Let.newToken,
      TokenType.Identifier.newToken("foo"),
      TokenType.Assign.newToken,
      TokenType.Int.newToken($1),
      TokenType.Add.newToken,
      TokenType.Int.newToken($2),
      TokenType.Semicolon.newToken,
      TokenType.Fun.newToken,
      TokenType.Identifier.newToken("bar"),
      TokenType.LParen.newToken,
      TokenType.RParen.newToken,
      TokenType.LBrace.newToken,
      TokenType.Return.newToken,
      TokenType.String.newToken("bar"),
      TokenType.Semicolon.newToken,
      TokenType.RBrace.newToken,
      TokenType.EOF.newToken,
    ]
    for i, token in tokens:
      assertToken(expectTokens[i], token)
