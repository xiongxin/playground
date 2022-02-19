#include <iostream>

class Vector {
private:
  double *elem;
  int sz;

public:
  Vector(int s) : elem{new double[s]}, sz{s} {
    for (int i = 0; i != s; ++i)
      elem[i] = 0;
  }

  ~Vector() { delete[] elem; }

  double &operator[](int);
  int size() const;
};

int main(int argc, char const *argv[]) { return 0; }
