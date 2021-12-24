#include <iostream>
#include <memory>

class Vector {
   private:
    double* elem;
    int sz;

   public:
    Vector(std::initializer_list<double> lst)
        : elem{new double[lst.size()]}, sz{static_cast<int>(lst.size())} {
        std::copy(lst.begin(), lst.end(), elem);
    }
    Vector(int s) : elem{new double[s]}, sz{s} {
        for (int i = 0; i != s; ++i) elem[i] = 0;
    }

    ~Vector() { delete[] elem; }

    double& operator[](int i);
    int size() const;
    void push_back(double);
};

int main(int argc, char const* argv[]) {
    Vector v1{1.1, 2.1};

    return 0;
}
