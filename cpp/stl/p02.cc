#include <iostream>

class A {

public:
  A() { std::cout << "A countructor()!\n"; }
};

class B {
public:
  B() { std::cout << "B countructor()!\n"; }

protected:
  A a;
};

int main(int argc, char const *argv[]) {
  B b{};
  return 0;
}
