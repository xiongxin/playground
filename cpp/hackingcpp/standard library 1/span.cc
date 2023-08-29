#include <array>
#include <iostream>
#include <span>
#include <vector>

void print_ints(std::span<int const> s) {
  for (auto i : s) std::cout << i << ' ';
  std::cout << '\n';
}

void change_ints(std::span<int> s) {
  for (auto i : s) i += 10000;
}

void print_chars(std::span<char const> s) {
  for (auto i : s) std::cout << i;
  std::cout << '\n';
}

int main() {
  std::vector<int> v{1, 2, 3, 4};
  change_ints(v);
  print_ints(v);
  std::array<int, 3> a{1, 2, 3};
  print_ints(a);
  std::string s = "Some Text";
  print_chars(s);
  std::string_view sv = s;
  print_chars(sv);
}
