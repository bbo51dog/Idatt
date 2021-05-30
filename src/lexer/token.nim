import tables

type
  TokenType* {.pure.} = enum
    Unknown
    Int
    String
    Identifier
    Add
    Sub
    Mul
    Div
    Semicolon
    Colon
    Dot
    Comma
    LParen
    RParen
    LBrace
    RBrace
    LBracket
    RBracket
    Equal
    Assign
    NotEqual
    Not
    GE
    GT
    LE
    LT
    Let
    Var
    If
    Else
    Elif

  Token* = ref object
    tokenType*: TokenType
    value*: string

const RESERVED* = {
  "let": TokenType.Let,
  "var": TokenType.Var,
  "if": TokenType.If,
  "else": TokenType.Else,
  "elif": TokenType.Elif,
}.toTable

proc newToken*(tokenType: TokenType, value: string = ""): Token =
  new result
  result.tokenType = tokenType
  result.value = value
