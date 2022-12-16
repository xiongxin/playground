struct Node
{
    int value;
    Node *left;
    Node *right;
    Node(int i = 0) : value(i), left(nullptr), right(nullptr)
    {
    }
};

Node *Node::*left = &Node::left;
Node *Node::*right = &Node::right;

template <typename T, typename... TP>
Node *traverse(T np, TP... paths)
{
    return (np->*...->*paths);
}

int main()
{
    // init binary tree structure:
    Node *root = new Node{0};
    root->left = new Node{1};
    root->left->right = new Node{2};
    // traverse binary tree:
    Node *node = traverse(root, left, right);
}