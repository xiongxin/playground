#include <iostream>
#include <string>

int main() {

  int x{};

  std::cout << x << '\n';

  std::string a{"abc"};

  if (a.compare("11abc1") == 0) {
    std::cout << a << '\n';
  } else if (a.compare("abc") == 0) {
    std::cout << "is equal abc" << '\n';
  }

  return 0;
}
