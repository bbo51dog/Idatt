import streams, strutils, tables
import token

type Lexer = ref object
  stream: Stream
  tokens: seq[Token]

proc newLexer(stream: Stream): Lexer =
  new result
  result.stream = stream

proc readWord(lexer: Lexer, current: char): string =
  var str = $current
  while lexer.stream.peekChar.isAlphaNumeric or lexer.stream.peekChar == '_':
    str &= lexer.stream.readStr(1)
  str

proc readDigits(lexer: Lexer, current: char): string =
  var str = $current
  while lexer.stream.peekChar.isDigit:
    str &= lexer.stream.readStr(1)
  str

proc readString(lexer: Lexer, separator: char): string =
  var str = ""
  while lexer.stream.peekChar != separator:
    str &= lexer.stream.readStr(1)
  discard lexer.stream.readChar
  str

proc nextToken(lexer: Lexer) =
  while isEmptyOrWhitespace(lexer.stream.peekStr(1)):
    discard lexer.stream.readChar
    if lexer.stream.atEnd:
      return
  var tokenType: TokenType
  var value: string
  let current = lexer.stream.readChar
  case current:
    of '+':
      tokenType = TokenType.Add
    of '-':
      tokenType = TokenType.Sub
    of '*':
      tokenType = TokenType.Mul
    of '/':
      tokenType = TokenType.Div
    of ';':
      tokenType = TokenType.Semicolon
    of ':':
      tokenType = TokenType.Colon
    of '.':
      tokenType = TokenType.Dot
    of ',':
      tokenType = TokenType.Comma
    of '(':
      tokenType = TokenType.LParen
    of ')':
      tokenType = TokenType.RParen
    of '{':
      tokenType = TokenType.LBrace
    of '}':
      tokenType = TokenType.RBrace
    of '[':
      tokenType = TokenType.LBracket
    of ']':
      tokenType = TokenType.RBracket
    of '=':
      if lexer.stream.peekChar == '=':
        tokenType = TokenType.Equal
        discard lexer.stream.readChar
      else:
        tokenType = TokenType.Assign
    of '!':
      if lexer.stream.peekChar == '=':
        tokenType = TokenType.NotEqual
        discard lexer.stream.readChar
      else:
        tokenType = TokenType.Not
    of '>':
      if lexer.stream.peekChar == '=':
        tokenType = TokenType.GE
        discard lexer.stream.readChar
      else:
        tokenType = TokenType.GT
    of '<':
      if lexer.stream.peekChar == '=':
        tokenType = TokenType.LE
        discard lexer.stream.readChar
      else:
        tokenType = TokenType.LT
    of '\'', '"':
      tokenType = TokenType.String
      value = lexer.readString(current)
    else:
      if current.isAlphaAscii:
        let word = lexer.readWord(current)
        tokenType = RESERVED.getOrDefault(word, TokenType.Identifier)
        if tokenType == TokenType.Identifier:
          value = word
      elif current.isDigit:
        value = lexer.readDigits(current)
        tokenType = TokenType.Int
      else:
        tokenType = TokenType.Unknown
  lexer.tokens.add tokenType.newToken(value)

proc tokenize(lexer: Lexer) =
  while not lexer.stream.atEnd:
    lexer.nextToken
  lexer.tokens.add TokenType.EOF.newToken
  lexer.stream.close

proc tokenizeString*(input: string): seq[Token] =
  var lexer = newLexer(newStringStream(input))
  lexer.tokenize
  lexer.tokens

proc tokenizeFile*(path: string): seq[Token] =
  var lexer = newLexer(newFileStream(path))
  lexer.tokenize
  lexer.tokens
