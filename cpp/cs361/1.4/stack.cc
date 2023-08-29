#include <iostream>
#include <stack>

void reportStackSize(const std::stack<int>& s) {
  std::cout << s.size() << " elements on stack\n";
}

void reportStackTop(const std::stack<int>& s) {
  // Leaves element on stack
  std::cout << "Top element: " << s.top() << '\n';
}

int main() {
  std::stack<int> s;
  int a = s.top();

  std::cout << a;
}
