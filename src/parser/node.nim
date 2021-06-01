type
  NodeType* = enum
    Add

  Node* = ref object of RootObj

  AstRoot* = seq[Node]
