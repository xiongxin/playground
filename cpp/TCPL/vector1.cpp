#include <iostream>

using namespace std;

struct Vector {
    int sz;        // number of elements
    double* elem;  // pointer to elements
};

void vector_init(Vector& v, int s) {
    v.elem = new double[s];  // allocate an array of s doubles;
    v.sz = s;
}

double read_and_sum(int s)
// read s integers from cin and return their sum; s is assumed to be positive
{
    Vector v;
    vector_init(v, s);
    for (int i = 0; i != s; ++i) cin >> v.elem[i];

    double sum = 0;
    for (int i = 0; i != s; ++i) sum += v.elem[i];

    return sum;
}

int main(int argc, char const* argv[]) {
    double a = read_and_sum(3);
    cout << a << endl;
    return 0;
}
