#include <iostream>

struct Vector {

    int sz;
    double *elem;
};

void vector_init(Vector &v, int s) {
    v.sz = s;
    v.elem = new double[s];
}

double read_and_sum(int s) {
    Vector v;
    vector_init(v, s);
    for (int i = 0; i != s; ++i)
        std::cin >> v.elem[i];

    double sum = 0;
    for (int i = 0; i != s; ++i)
        sum += v.elem[i];

    return sum;
}

int main(int argc, char const *argv[]) {
    Vector v;
    vector_init(v, 10);
    std::cout << v.sz << std::endl;
    std::cout << v.elem << std::endl;

    std::cout << read_and_sum(3) << std::endl;
    return 0;
}
