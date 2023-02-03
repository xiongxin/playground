#include <iostream>

class A
{
public:
  A () = default;

  A (const A &a) { std::cout << "copy cons\n"; }

  A &
  operator= (A rhs)
  {
    std::cout << "copy assigment\n";
    return *this;
  }
};

int
main (int argc, char const *argv[])
{
  A a1{};
  A a2{};

  a2 = a1;

  return 0;
}
