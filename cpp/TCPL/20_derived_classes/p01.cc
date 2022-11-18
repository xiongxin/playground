#include <iostream>

class Parent {

public:
  Parent() { print(); }

  void print() { std::cout << 10 << std::endl; }
};

class Child : public Parent {

public:
  Child() { print(); }

  void print() { std::cout << 20 << std::endl; }
};

int main() {
  Parent *p = new Child();

  return 0;
}
