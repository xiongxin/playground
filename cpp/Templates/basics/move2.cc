#include <iostream>
#include <utility>

class X {};
void g(X &) { std::cout << "g() for variable\n"; }
void g(X const &) { std::cout << "g() for constant\n"; }
void g(X &&) { std::cout << "g() for movable object\n"; }
// template <typename T> void f(T &&val) { g(std::forward<T>(val)); }
void f(X &val) { g(val); }
void f(X const &val) { g(val); }
void f(X &&val) { g(std::move(val)); }
int main() {
  X v;
  X const c;
  f(v);
  f(c);
  f(X());
  f(std::move(v));
}
