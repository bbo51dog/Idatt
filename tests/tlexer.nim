import unittest
import lexer/lexer, lexer/token

suite "Lexer":
  test "tokenize calculation":
    let tokens = "(123 + 2 ) * 3".tokenizeString
    let expectTokens = [
      TokenType.LParen.newToken,
      TokenType.Int.newToken($123),
      TokenType.Add.newToken,
      TokenType.Int.newToken($2),
      TokenType.RParen.newToken,
      TokenType.Mul.newToken,
      TokenType.Int.newToken($3),
    ]
    for i, token in tokens:
      let expectToken = expectTokens[i]
      doAssert token[] == expectToken[], $expectToken.tokenType &
          " expected, " & $token.tokenType & " passed"
