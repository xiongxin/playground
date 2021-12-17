#include <iostream>

class Vector {
   public:
    Vector(int s) : elem{new double[s]}, sz{s} {}
    double read_and_sum(int s) {
        Vector v(s);
        for (int i = 0; i != s; ++i) std::cin >> v.elem[i];

        double sum = 0;
        for (int i = 0; i != s; ++i) sum += v.elem[i];

        return sum;
    }

    double& operator[](int idx) { return elem[idx]; }

    int size() { return sz; }

   private:
    double* elem;
    int sz;
};

int main(int argc, char const* argv[]) {
    Vector v(6);

    std::cout << "v.sz = " << v.size() << std::endl;

    return 0;
}
