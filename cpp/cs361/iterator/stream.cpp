// istream_iterator example
#include <iostream>  // std::cin, std::cout
#include <iterator>  // std::istream_iterator
#include <sstream>
#include <string>
int main() {
  std::string abc{"abcdefg"};
  std::istream_iterator<std::string> is{abc};
  return 0;
}
