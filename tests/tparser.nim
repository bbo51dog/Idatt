import unittest
import lexer/token
import parser/parser

suite "Parser":
  test "Simple parse":
    let parser = @[
      TokenType.Int.newToken($1),
      TokenType.Add.newToken,
      TokenType.Int.newToken($2),
    ].parse

