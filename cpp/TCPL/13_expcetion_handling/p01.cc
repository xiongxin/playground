#include <iostream>
#include <memory>
#include <utility>
#include <vector>

class A {
public:
  int m_int;
  A(int i) : m_int{i} {}
  ~A() { std::cout << "~A()" << m_int << "\n"; }
};

// Driver Code
int main() {
  A a{1};
  A a1{2};
  a1 = std::move(a);
  a1.m_int = 2;
  std::cout << a.m_int << "\n";
  std::cout << a1.m_int << "\n";

  return 0;
}
