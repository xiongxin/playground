// std::iterator example
#include <iostream> // std::cout
#include <iterator> // std::iterator, std::input_iterator_tag

template <int N> constexpr bool Small_size() { return N <= 8; }

int main() {
  bool a = Small_size<7>();
  std::cout << std::boolalpha << a << "\n";
  return 0;
}
