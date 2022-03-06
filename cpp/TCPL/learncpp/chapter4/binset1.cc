#include <bitset>
#include <iostream>

int main(int argc, char const *argv[]) {

  std::bitset<4> bin1{0b1010};

  int a = static_cast<int>(bin1.to_ullong());

  std::cout << bin1 << std::endl;
  std::cout << a << std::endl;

  return 0;
}
