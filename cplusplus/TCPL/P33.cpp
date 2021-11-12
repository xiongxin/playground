#include <iostream>

template <typename T>
class Vector {
   private:
    T* elem;
    int sz;

   public:
    Vector(int s) : elem{new T[s]}, sz{s} {}
    ~Vector() { delete[] elem; }

    Vector(const Vector& a);                   // copy constructor
    Vector<T>& operator=(const Vector<T>& a);  // copy assignment

    T& operator[](int i) { return elem[i]; }
    const T& operator[](int i) const { return elem[i]; }

    int size() const { return sz; }

    Vector(Vector<T>&& a);                // move constructor
    Vector<T>& operator=(Vector<T>&& a);  // move assignment
};

template <typename T>
Vector<T>::Vector(const Vector& a) : elem{new double[a.sz]}, sz{a.sz} {
    for (int i = 0; i != sz; ++i) elem[i] = a.elem[i];
}

// copy assignment
template <typename T>
Vector<T>& Vector<T>::operator=(const Vector<T>& a) {
    std::cout << "copy assignment" << std::endl;
    double* p = new double[a.sz];
    for (int i = 0; i != a.sz; ++i) p[i] = a.elem[i];

    delete[] elem;  // delete old elements
    elem = p;
    sz = a.sz;

    return *this;
}

// move constructor
template <typename T>
Vector<T>::Vector(Vector<T>&& a) : elem{a.elem}, sz{a.sz} {
    std::cout << "move constructor" << std::endl;
    a.elem = nullptr;
    a.sz = 0;
}

// move assignment
template <typename T>
Vector<T>& Vector<T>::operator=(Vector<T>&& a) {
    std::cout << "move assignment" << std::endl;
    elem = a.elem;
    sz = a.sz;

    a.elem = nullptr;
    a.sz = 0;

    return *this;
}

Vector<double> getVector() {
    Vector<double> v(10000);

    return v;
}

template <typename T>
T* begin(Vector<T>& x) {
    return &x[0];
}
template <typename T>
T* end(Vector<T>& x) {
    return x.begin() + x.size();
}

class P33 {
   public:
    int id;
    P33(int i) : id{i} {}
    // P33(P33&&);
    // P33& operator=(P33&&);
    P33& operator=(const P33&);
    P33(const P33&);
    ~P33() { std::cout << id << "!!!!!!!!" << std::endl; }
};

struct PA {
    int id;
};

PA getPA() {
    PA pa{};

    return pa;
}

P33::P33(const P33& a) : id(a.id) {
    std::cout << "copy assignment P33!!!" << std::endl;
}

// P33::P33(P33&& a) : id(a.id) {
//     std::cout << "move assignment P33!" << std::endl;
//     a.id = 0;
// }

// P33& P33::operator=(P33&& a) {
//     std::cout << "move assignment P33!!" << std::endl;

//     id = a.id;
//     a.id = 0;

//     return *this;
// }

P33& P33::operator=(const P33& a) {
    std::cout << "copy assignment P33!!!!!" << std::endl;
    id = a.id;
    return *this;
}

P33 getP33() {
    P33 p(84848);

    return p;
}

int main() {
    Vector<double> v(100);
    Vector<double> v1(10);
    v1 = v;
    std::cout << v.size() << std::endl;

    // move constructor
    Vector<double> v2(std::move(v1));
    std::cout << v1.size() << std::endl;

    // move assignment
    Vector<double> v3(10);
    v3 = std::move(v2);

    // move assignment
    Vector<double> v4(10);
    v4 = getVector();
    std::cout << "=============" << std::endl;
    // P33 p332(1);
    auto p332 = getP33();
    // auto p333 = p332;
    // P33 p334(p333);

    // P33 p335(10);
    // p334 = p334;
    // return 0;

    auto a = getPA();
}