#include <algorithm>
#include <initializer_list>

class Vector {
  private:
    double *elem;
    int sz;

  public:
    Vector(int s) : elem{new double[s]}, sz{s} {
        for (int i = 0; i < s; i++) {
            elem[i] = 0;
        }
    }
    Vector(const Vector &v);
    Vector(std::initializer_list<double> lst);
    ~Vector() { delete[] elem; }

    double &operator[](int i) { return elem[i]; }
    int size() const { return sz; }
    void push_back(double);
};

Vector::Vector(std::initializer_list<double> lst)
    : elem{new double[lst.size()]}, sz{lst.size()} {

    std::copy(lst.begin(), lst.end(), elem);
}