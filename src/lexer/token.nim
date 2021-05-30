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
    And
    Or
    Let
    Var
    Const
    If
    Else
    Elif
    While
    For
    Fun
    Return

  Token* = ref object
    tokenType*: TokenType
    value*: string

const RESERVED* = {
  "and": TokenType.And,
  "or": TokenType.Or,
  "let": TokenType.Let,
  "var": TokenType.Var,
  "const": TokenType.Const,
  "if": TokenType.If,
  "else": TokenType.Else,
  "elif": TokenType.Elif,
  "While": TokenType.While,
  "for": TokenType.For,
  "fun": TokenType.Fun,
  "return": TokenType.Return,
}.toTable

proc newToken*(tokenType: TokenType, value: string = ""): Token =
  new result
  result.tokenType = tokenType
  result.value = value
