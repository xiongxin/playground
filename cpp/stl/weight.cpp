#include <iostream>
#include <memory>
#include <string>
#include <utility>

class Weight {

public:
  Weight() = default;
  Weight(int i, std::unique_ptr<std::string> ptr_str)
      : m_i{i}, m_ptr_str{std::move(ptr_str)} {}

  int m_i;
  std::unique_ptr<std::string> m_ptr_str;
};

class WD : public Weight {
public:
  WD() {}
};

int main(int argc, char const *argv[]) {

  Weight w{1, std::make_unique<std::string>()};

  Weight w1{};

  std::cout << w1.m_i << ":" << w1.m_ptr_str.get() << "\n";
  WD wd{};
  std::cout << wd.m_i << ":" << wd.m_ptr_str.get() << "\n";
  return 0;
}
