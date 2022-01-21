module basicTree1;

struct Tree(Type) {
  Type value;
  Tree[] children;

  size_t size() {
    size_t s = 1;
    foreach (child; children)
      s += child.size();
    return s;
  }

  bool isLeaf() @property {
    return children.length == 0;
  }
}

void main(string[] args) {
  auto tree = Tree(0, [Tree(1), Tree(2, [Tree(3), Tree(4), Tree(5)])]);
  assert(!tree.isLeaf);
  assert(tree.size() == 6);
}
