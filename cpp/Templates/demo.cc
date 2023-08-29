#include <algorithm>
#include <iostream>
#include <iterator>
#include <list>
#include <string>
#include <vector>

using namespace std;

int main() {
  int a[5] = {1, 2, 3, 4, 5};
  vector<int> alist(2, 0);
  alist.resize(2);
  vector<int>::iterator pos = alist.begin();
  ++pos;
  copy(a, a + 5, inserter(alist, pos));
  cout << *pos;
  return 0;
}
