#include <iostream>

int main(void) {

  std::cout << "location of code : " << (void *)&main << "\n";
  std::cout << "location of code : " << new int(100) << "\n";
  int x = 3;
  std::cout << "location of code : " << &x << "\n";

  return 0;
}
