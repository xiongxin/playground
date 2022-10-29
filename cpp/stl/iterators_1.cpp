#include <iostream>
#include <vector>

int main() {
  std::vector<int> v{1, 2, 3, 4, 5, 6, 7};
  auto i = rbegin(v);
  auto e = rend(v);

  std::cout << *i << '\n';
  std::cout << *(i + 2) << '\n';
  // std::cout << *e << '\n'; // undefined behavior!

  ++i;
  std::cout << *i << '\n';

  i += 2;
  std::cout << *i << '\n';

  --i;
  std::cout << *i << '\n';
  i.base();
  i += 5;
  if (i == rend(v))
    std::cout << "at rend\n";
}
