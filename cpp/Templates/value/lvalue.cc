#include <stdio.h>
#include <utility>

class A {
public:
  A() {
    printf("A ()"
           "\n");
  }
  A(const A &) {
    printf("A (&)"
           "\n");
  }
  A(A &&) {
    printf("A (&&)"
           "\n");
  }
  A(const A &&) {
    printf("A (const &&)"
           "\n");
  }
  ~A() {
    printf("~ A ()"
           "\n");
  }
};

template <typename T1, typename T2> void emplace_back(T1 &&e1, T2 &&e2) {}

template <typename T> void baz(T t) { T &k = t; }

int main() {
  A obj;
  // A obj2(std::move(obj));               // 1-st approach
  A obj3(static_cast<A &&>(obj)); // 2-nd approach

  int a = 12;
  int b = 13;
  emplace_back(obj, A{});
  int ii = 4;
  baz<int &>(ii);
}
