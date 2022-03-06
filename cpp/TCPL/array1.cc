#include <algorithm>
#include <iostream>
#include <string>

int main(int argc, char const *argv[]) {
  int v5[] = {1, 2, 3};
  const char *p = "Heraclitus";
  const char *q = "Heraclitus";

  if (p == q) {
    std::cout << "OK" << std::endl;
  }

  std::cout << &p << std::endl;
  std::cout << &q << std::endl;

  char alpha[] = "Jens\000Munk";

  std::cout << alpha << std::endl;
  std::string s = R"(\w\\w)";
  // I’m pretty sure I got that right
  return 0;
}
