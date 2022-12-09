typedef struct {
  struct BinaryTree *lhs;
  int x;
  struct BinaryTree *rhs;
} BinaryTreeNode;

typedef struct {
  enum { Leaf, Node } tag;
  union {
    int leaf;
    BinaryTreeNode node;
  } data;
} BinaryTree;

int main(int argc, char const *argv[]) {
  BinaryTree *bt;
  bt->tag = Leaf;
  bt->data.leaf = 100;

  return 0;
}
