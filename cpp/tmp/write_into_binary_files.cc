#include <cstring>
#include <fstream>
#include <iostream>

int main(int argc, char const *argv[]) {
  std::ofstream fs{"a.dat", std::ios::out | std::ios::binary | std::ios::trunc};
  int a = 234567;
  fs.write(reinterpret_cast<const char *>(&a), sizeof a);
  fs.close();
  return 0;
}
