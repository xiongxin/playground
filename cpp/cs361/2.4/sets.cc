#include <bits/stdc++.h>

using namespace std;

int main(int argc, char const* argv[]) {
  set strs{"a", "b", "c", "d", "e"};
  list l{"f", "g", "h"};
  cout << *strs.lower_bound("c") << '\n';
  cout << *strs.upper_bound("c") << '\n';

  copy(l.begin(), l.end(), inserter(strs, strs.end()));

  for (const auto& s : strs) {
    cout << s << '\t';
  }
  cout << '\n';

  return 0;
}
