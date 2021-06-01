type
  NodeType* = enum
    IntLiteral

    Add

  Node* = ref object of RootObj
    nodeType*: NodeType

  TerminalNode* = ref object of Node
    value: string

  NonTerminalNode* = ref object of Node
    left*: Node
    right*: Node

  AstRoot* = seq[Node]

proc newTerminalNode*(nodeType: NodeType, value: string): TerminalNode =
  new result
  result.nodeType = nodeType
  result.value = value

proc newNonTerminalNode*(nodeType: NodeType, left: Node, right: Node): NonTerminalNode =
  new result
  result.nodeType = nodeType
  result.left = left
  result.right = right
