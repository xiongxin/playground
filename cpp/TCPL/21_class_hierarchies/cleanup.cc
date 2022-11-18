#include <iostream>

class i {
public:
  virtual ~i() { std::cout << "i\n"; }
};

class c : public i {
public:
  // virtual ~c() { std::cout << "c\n"; }
};

class b : public c {
public:
  virtual ~b() { std::cout << "b\n"; }
};

class a : public i {
public:
  virtual ~a() { std::cout << "a\n"; }
};

int main(int argc, char const *argv[]) {
  i *b1 = new b();
  delete b1;
  return 0;
}
