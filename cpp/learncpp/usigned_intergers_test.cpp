#include <iostream>

int main(int argc, char const *argv[]) {
  signed int s{-1};
  unsigned int u{1};

  if (s < u)
    std::cout << "-1 is less than 1" << std::endl;
  else
    std::cout << "1 is less than -1" << std::endl;
  return 0;
}
