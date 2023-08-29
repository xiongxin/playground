#include <array>
#include <cstddef>
#include <iostream>
#include <new>

template <class _Ty, size_t _Size>
union uarray {
  std::array<_Ty, _Size> c;

  template <class... Args>
  uarray(Args &...args) {
    for (auto &v : c) new (&v) _Ty(args...);
  }
  ~uarray() {
    for (auto &v : c) v.~_Ty();
  }
};

class A {
 public:
  A(int a_) : a{a_} {}
  int get_a() { return a; }

 private:
  int a;
};

int main(int argc, char const *argv[]) {
  int a = 1;
  uarray<A, 100> as(a);
  for (auto &ai : as.c) {
    std::cout << ai.get_a() << "\n";
  }

  int b = 12;

  return 0;
}
