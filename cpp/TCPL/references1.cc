#include <iostream>
#include <string>

int main(int argc, char const *argv[]) {
  int var = 0;
  int &rr{var};
  ++rr;

  int *pp = &rr;

  std::cout << rr << std::endl;

  std::string &&rr3{"Oxford"};
  return 0;
}
