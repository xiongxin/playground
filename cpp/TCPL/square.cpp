#include <iostream>
using namespace std;  // make names from std visible without std::

double square(double x) { return x * x; }

void print_square(double x) {
    cout << "the square of " << x << " is " << square(x) << endl;
}

int main(int argc, char const *argv[]) {
    print_square(1.234);
    return 0;
}
