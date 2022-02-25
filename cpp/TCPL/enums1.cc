#include <iostream>

int main(int argc, char const *argv[]) {

  enum class Flag : char { x = 1, y = 2, z = 4, e = 8 };

  Flag f0{};

  std::cout << (f0 == Flag::x) << std::endl;

  return 0;
}
