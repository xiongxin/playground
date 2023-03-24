#include <iostream>
#include <string>

int main(int const argc, char const* const* argv) {
  if (argc < 3) {
    std::cerr << "Usage:\\n " << argv[0] << " <word> <times>\\n";
    return EXIT_FAILURE;
  }
  auto word = std::string(argv[1]);
  int times = std::stoi(argv[2]);
  for (int i = 0; i < times; ++i) {
    std::cout << word << ' ';
  }
  std::cout << '\n';
}
