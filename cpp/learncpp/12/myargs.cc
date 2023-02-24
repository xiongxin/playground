// Program: MyArgs
#include <iostream>
#include <sstream>
#include <string>

int main(int argc, char* argv[]) {
  std::cout << "There are " << argc << " arguments:\n";

  // Loop through each argument and print its number and value
  for (int count{0}; count < argc; ++count) {
    std::cout << count << ' ' << argv[count] << '\n';
  }

  std::istringstream is{" 12.2 34 56  "};

  for (double myint{}; is >> myint;) {
    std::cout << myint << ' ';
  }
  std::cout << '\n';
  return 0;
}
