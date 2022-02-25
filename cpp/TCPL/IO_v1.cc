#include <algorithm>
#include <iostream>
#include <string>
#include <vector>

struct Entry {
  std::string name;
  int number;
};

std::ostream &operator<<(std::ostream &os, const Entry &e) {
  return os << "{\"" << e.name << "\"," << e.number << "}";
}

int main(int argc, char const *argv[]) {
  Entry e{"name", 12};
  std::cout << e << std::endl;

  std::vector<Entry> phone_book = {{"David Hume", 123456},
                                   {"Karl Popper", 234567},
                                   {"Bertrand Arthur William Russell", 345678}};
  for (auto &e : phone_book)
    std::cout << e << std::endl;

  for (size_t i = 0; i != phone_book.size(); ++i)
    std::cout << phone_book[i] << std::endl;

  std::string m{"Mary had"};
  auto p = std::find(m.begin(), m.end(), 'h');
  std::cout << *p << std::endl;
  return 0;
}
