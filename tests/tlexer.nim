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
    ]
    for i, token in tokens:
      assertToken(expectTokens[i], token)

