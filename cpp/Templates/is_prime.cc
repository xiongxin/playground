#include <bits/stdc++.h>
using namespace std;

long long mod(long long power, long long n) {
  if (power <= 10) {
    return static_cast<long long>(pow(2.0, power)) % n;
  }

  if (power % 2 == 0) {
    return (mod(power / 2, n) * mod(power / 2, n)) % n;
  } else {
    return (mod(power / 2, n) * mod(power / 2 + 1, n)) % n;
  }
}

bool is_prime(long long n) { return mod(n, n) == 2; }

int main(int argc, char const *argv[]) {
  cout << is_prime(499979) << "\n";
  return 0;
}
