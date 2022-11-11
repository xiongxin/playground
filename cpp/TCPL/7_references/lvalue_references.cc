#include <iostream>

int main(int argc, char const *argv[]) {
  int var = 0;
  int &rr{var};
  ++rr;
  std::cout << rr << "\n";
  std::cout << &var << "\n";
  int *pp = &rr;
  std::cout << pp << "\n";
  (*pp)++;
  std::cout << rr << "\n";
  return 0;
}
