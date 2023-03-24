#include <fstream>  // file stream header
#include <iostream>
int main() {
  std::ofstream os{"squares.dat", std::ios::out | std::ios::binary};
  char a = '[', b = ']';
  if (os.good()) {
    for (int x = 1; x <= 6; ++x) {
      // write x space x² newline
      // os << x << ' ' << (x * x) << '\n';
      os.write(reinterpret_cast<const char*>(&x), sizeof(int));
      os.write(reinterpret_cast<const char*>(&a), sizeof(char));
      int tmp = x * x;
      os.write(reinterpret_cast<const char*>(&tmp), sizeof(int));
      os.write(reinterpret_cast<const char*>(&b), sizeof(char));
    }
  }
}  // file is automatically closed
