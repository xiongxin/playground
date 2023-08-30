#include <iostream>
#include <range/v3/all.hpp>
#include <range/v3/range/conversion.hpp>
#include <string>

auto print_subrange = [](std::ranges::viewable_range auto &&r) {
  std::cout << "[";
  for (int pos{}; auto elem : r)
    std::cout << (pos++ ? " " : "") << elem;
  std::cout << "] ";
};

int main() {
  using namespace ranges;

  std::vector<char> input{'a', 'b', 'c', 'd', 'e'};
  auto result =
      input | views::sliding(2) | views::join | ranges::to<std::string>();
  std::cout << result << '\n';

  const auto v = {1, 2, 3, 4, 5, 6};

  for (const unsigned width : views::iota(1U, 1U + v.size())) {
    auto const windows = v | views::sliding(width);
    std::cout << "All sliding windows of width " << width << ": ";
    ranges::for_each(windows, print_subrange);
    std::cout << '\n';
  }
}
