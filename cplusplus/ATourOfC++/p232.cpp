#include <iostream>

class Vector {
  public:
    Vector(int s) : elem(new double[s]), sz(s) {}
    double &operator[](int i) {
        return elem[i];
    }

    int size() const { return sz; }

  private:
    double *elem;
    int sz;
};

double read_and_sum(int s) {
    Vector v(s);
    for (int i = 0; i != v.size(); ++i)
        std::cin >> v[i];

    double sum = 0;
    for (int i = 0; i != v.size(); ++i)
        sum += v[i];

    return sum;
}

enum class Color { red,
                   blue,
                   green };

enum class Traffic_light { green,
                           yellow,
                           red };

Color &operator++(Color &c) {
    switch (c) {
    case Color::red:
        return c = Color::blue;
    case Color::blue:
        return c = Color::green;
    case Color::green:
        return c = Color::red;
    }
}

int main(int argc, char const *argv[]) {
    Vector v(6);
    std::cout << v.size() << std::endl;
    Color c = Color::blue;
    ++c;
    if (c == Color::green) {
        std::cout << "green" << std::endl;
    }
    return 0;
}
