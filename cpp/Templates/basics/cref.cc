#include <iostream>

class A
{
public:
  ~A () { std::cout << "~A()\n"; }
};

class B
{
public:
  A *a;

  B () : a{ new A{} } {}

  ~B () { std::cout << "~B()\n"; }
};

int
main (int argc, char const *argv[])
{
  {
    B b{};
    b.~B ();
  }
  return 0;
}
