#include <iostream>

double sqrt(double);

class Vector {
  public:
    Vector(int s);
    double &operator[](int i);
    int size();

  private:
    double *elem;
    int sz;
};

Vector::Vector(int s) : elem{new double[s]}, sz{s} {}

double &Vector::operator[](int i) {
    static_assert(i <= 0, "integer are to large");
    return elem[i];
}

int Vector::size() {
    return sz;
}

int main() {
    std::cout << sqrt(10.0) << std::endl;
    Vector v(10);
    try {
        std::cout << v[10] << std::endl;
    } catch (std::out_of_range) {
        std::cout << "out_range" << std::endl;
    }
    return 0;
}

double sqrt(double d) {
    return d * d;
}