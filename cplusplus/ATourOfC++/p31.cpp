#include <iostream>
#include <string>
#include <vector>

class Martix {
  public:
    int a;
    int b;

  public:
    Martix(int a, int b) : a(a), b(b) {}
    Martix operator+(Martix &m) {
        return Martix(a + m.a, b + m.b);
    }
    ~Martix() {
        std::cout << "~Martix()" << std::endl;
    }
};

struct Entry {
    std::string name;
    int value;
};

Entry read_entry(std::istream &is) {
    std::string s;
    int i;
    is >> s >> i;

    return {s, i};
}

int main(int argc, char const *argv[]) {

    {
        Martix m1(1, 2);
        Martix m2(3, 4);
        Martix m3 = m1 + m2;
        std::cout << m3.a << " " << m3.b << std::endl;
    }

    {
        Martix *m4 = new Martix(1, 2);
        std::cout << m4->a << " " << m4->b << std::endl;

        delete m4;
    }

    auto [name, value] = read_entry(std::cin);
    std::cout << name << " " << value << std::endl;
    return 0;
}
