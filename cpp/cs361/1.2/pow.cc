#include <iostream>

long long pow(long long x, int n) {
  if (n == 0) return 1;
  if (n == 1) return x;

  if (n % 2 == 0) {
    return pow(x * x, n / 2);
  } else {
    return pow(x * x, n / 2) * x;
  }
}

int main(int argc, char const *argv[]) {
  std::cout << pow(2, 60) << '\n';
  return 0;
}
