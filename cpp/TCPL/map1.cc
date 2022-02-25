#include <iostream>
#include <map>
#include <string>

std::map<std::string, double> table;

int main(int argc, char const *argv[]) {
  double &v = table["a"];
  std::cout << v << std::endl;
  v = 1000;

  std::cout << v << std::endl;
  std::cout << table["a"] << std::endl;
  return 0;
}
