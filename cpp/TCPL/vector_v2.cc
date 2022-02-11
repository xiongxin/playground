#include <iostream>
#include <stdexcept>

class Vector {
public:
  Vector(int s) : elem{new double[s]}, sz{s} {}
  double &operator[](int i) {
    if (i < 0 || sz <= i)
      throw std::out_of_range("Vector::operator[]");
    return elem[i];
  }
  int size() { return sz; }

private:
  double *elem;
  int sz;
};

double read_and_sum(int s) {
  Vector v(s);
  for (int i = 0; i != v.size(); ++i)
    std::cin >> v[i];

  double sum = 0;
  for (int i = 0; i != v.size(); ++i) {
    sum += v[i];
  }

  return sum;
}
int main(int argc, char const *argv[]) {

  Vector v(6);

  std::cout << v.size() << std::endl;

  std::cout << read_and_sum(3) << std::endl;

  return 0;
}
