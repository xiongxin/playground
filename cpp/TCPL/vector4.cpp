#include <iostream>
#include <memory>
#include <vector>

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

    Vector(const Vector& a);             // copy constructor
    Vector& operator=(const Vector& a);  // copy assignment

    Vector(Vector&& a);             // move constructor
    Vector& operator=(Vector&& a);  // move assignment

    // double& operator[](int i);
    const double& operator[](int i) const;

    int size() const { return sz; }
};

const double& Vector::operator[](int i) const { return elem[i]; }

Vector::Vector(const Vector& a)  // copy constructor
    : elem{new double[a.sz]},    // allocate space for elements
      sz{a.sz} {
    for (int i = 0; i != sz; ++i) elem[i] = a.elem[i];  // copy elements
}

Vector& Vector::operator=(const Vector& a)  // copy assignment
{
    double* p = new double[a.sz];
    for (int i = 0; i != a.sz; ++i) p[i] = a.elem[i];

    delete[] elem;
    elem = p;
    sz = a.sz;

    return *this;
}

Vector::Vector(Vector&& a) : elem{a.elem}, sz{a.sz} {
    a.elem = nullptr;  // now a has no elements
    a.sz = 0;

    std::cout << "move construct11" << std::endl;
}

Vector& Vector::operator=(Vector&& a) {
    std::cout << "move construct22" << std::endl;

    if (this != &a) {
        delete[] elem;

        elem = a.elem;
        sz = a.sz;

        a.elem = nullptr;
        a.sz = 0;
    }

    return *this;
}

Vector f() {
    Vector z{100};

    return z;
}

Vector f1(Vector v) {
    Vector z(10);

    return z;
}

int main(int argc, char const* argv[]) {
    Vector v1{1.1, 2.1, 3.1, 4.1, 5.1};
    Vector v2 = std::move(v1);
    std::cout << v1.size() << std::endl;
    std::vector<Vector> vv;
    vv.push_back(f());
    Vector v3{1, 2};
    v3 = f();
    std::cout << v3[0] << std::endl;
    std::cout << "------------------" << std::endl;
    Vector v4 = f1(Vector{100, 1});
    std::cout << "------------------" << std::endl;
    Vector v5 = std::move(f());
    return 0;
}
