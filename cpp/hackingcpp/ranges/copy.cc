#include <iostream>
#include <range/v3/algorithm/copy.hpp>
#include <range/v3/algorithm/copy_n.hpp>
#include <string>
#include <vector>

using std::cout;

int main() {
  std::vector<int> const vi{1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
  std::vector<int> tagter{};
  tagter.resize(10, 0);
  // prints: [2,4,6,8,10]

  ranges::copy(vi.begin(), vi.end(), tagter.begin());
  for (auto i : tagter) {
    cout << i << '\t';
  }
  cout << '\n';

  std::vector<int> tagter1(10, 100);
  // prints: [2,4,6,8,10]
  ranges::copy_n(vi.begin(), 5, tagter1.begin());
  for (auto i : tagter1) {
    cout << i << '\t';
  }
  cout << '\n';
}
