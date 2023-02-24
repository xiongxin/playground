#include <iostream>
#include <iterator>
#include <utility>

int main(int argc, char const *argv[]) {
  int array[]{30, 50, 20, 10, 40};
  constexpr int length{static_cast<int>(std::size(array))};

  for (int i = 0; i < length; ++i) {
    int thisMin = i;
    for (int j = i + 1; j < length; ++j)
      if (array[j] < array[thisMin]) thisMin = j;

    std::swap(array[i], array[thisMin]);
  }
  // Now that the whole array is sorted, print our sorted array as proof it
  // works
  for (int index{0}; index < length; ++index) std::cout << array[index] << ' ';

  std::cout << '\n';

  return 0;
}
