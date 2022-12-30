#include <iostream>

decltype(auto) fn_A(int i) { return i; }
decltype(auto) fn_B(int i) { return (i); }
decltype(auto) fn_C(int i) { return (i + 1); }
decltype(auto) fn_D(int i) { return i++; }
decltype(auto) fn_E(int i) { return ++i; }
decltype(auto) fn_F(int i) { return (i >= 0 ? i : 0); }
decltype(auto) fn_G(int i, int j) { return i >= j ? i : j; }
struct S {
  int i = 0;
};

decltype(auto) fn_H() { return (S{}); }
decltype(auto) fn_I() { return (S{}.i); }

template <typename T> constexpr const char *category = "prvalue";
template <typename T> constexpr const char *category<T &> = "lvalue";
template <typename T> constexpr const char *category<T &&> = "xvalue";

#define SHOW(E) std::cout << #E << ": " << category<decltype((E))> << std::endl

int main() {
  // 返回 prvalue 的函数是安全的，而返回 lvalue 和 xvalue
  // 的函数是不安全的，因为它们是已经离开了作用域的变量的引用。
  // SHOW(fn_A(0));
  // SHOW(fn_B(0));
  // SHOW(fn_C(0));
  // SHOW(fn_D(0));
  // SHOW(fn_E(0));
  // SHOW(fn_F(0));
  // SHOW(fn_G(0, 1));
  // SHOW(fn_H());
  // SHOW(fn_I());
  SHOW("abc");
  SHOW(main);
  int a[] = {1, 2};
  SHOW(a[0]);
  S s{};
  SHOW(s.i);
  SHOW(S{}.i);
}
