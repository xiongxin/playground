#include <iostream>

struct Vector {
    int sz;
    double *elem;
};

void vector_init(Vector &v, int s) {
    v.sz = s;
    v.elem = new double[s]; // allocate an array of s doubles
}

int main(int argc, char const *argv[]) {
    Vector v{};
    std::cout << v.sz << std::endl;
    std::cout << v.elem << std::endl;
    vector_init(v, 10);
    std::cout << v.sz << std::endl;
    return 0;
}
