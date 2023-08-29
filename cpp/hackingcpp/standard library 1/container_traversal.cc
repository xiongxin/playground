#include <bits/stdc++.h>
using namespace std;

int main(int argc, char const* argv[]) {
  vector v{1, 2, 3, 4, 5, 6, 7};
  for (int i : v | views::reverse) {
    cout << i << '\n';
  }
  cout << "============\n";
  ranges::for_each(v | views::reverse, [](int& i) { cout << i++ << '\n'; });
  cout << "============\n";
  ranges::for_each(v | views::reverse, [](int i) { cout << i << '\n'; });
  return 0;
}
