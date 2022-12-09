#include <cstddef>
class BadString {
public:
  BadString(char const *);
  // character access through subscripting:
  char &operator[](std::size_t);
  char const &operator[](std::size_t) const;
  // implicit conversion to null-terminated byte string:
  operator char *();
  operator char const *();
};

template <typename T> class MyString {
public:
  MyString(T const *); // converting constructor
  MyString() = default;
};

template <typename T> void truncate(MyString<T> const &, int) {}

template <typename T> void strange(T &&, T &&) {}
template <typename T> void bizarre(T &&, double &&) {}

struct S {
  void f1();    // implicit *this parameter is an lvalue reference (see below)
  void f2() &&; // implicit *this parameter is an rvalue reference
  void f3() &;  // implicit *this parameter is an lvalue reference
};

int main() {
  BadString str("correkt");
  str[5] = 'c'; // possibly an overload resolution ambiguity!
  MyString<char> str1, str2;
  truncate<char>("Hello World", 5);
  strange(1.2, 3.4);
  double val = 1.2;
  strange(val, val);
}
