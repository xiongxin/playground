class Vector {
private:
  double *elem;
  int sz;

public:
  Vector(int s); // constructor: establish invariant, acquire resources
  ~Vector() { delete[] elem; } // destructor: release resources

  Vector(const Vector &a);            // copy constructor
  Vector &operator=(const Vector &a); // copy assignment

  Vector(Vector &&a);            // move constructor
  Vector &operator=(Vector &&a); // move assignment

  double &operator[](int i);
  const double &operator[](int i) const;

  int size() const;
};

Vector::Vector(const Vector &a)        // copy constructor
    : elem{new double[a.sz]}, sz{a.sz} // allocate space for elements
{
  for (int i = 0; i != sz; ++i) // copy elements
    elem[i] = a.elem[i];
}

Vector &Vector::operator=(const Vector &a) // copy assignment
{
  double *p = new double[a.sz];
  for (int i = 0; i != a.sz; ++i)
    p[i] = a.elem[i];

  delete[] elem;
  elem = p;
  sz = a.sz;

  return *this;
}

Vector operator+(const Vector &a, const Vector &b) {
  // if (a.size() != b.size())
  //   throw Vector_size_mismatch{};
  Vector res(a.size());
  for (int i = 0; i != a.size(); ++i)
    res[i] = a[i] + b[i];
  return res;
}

Vector::Vector(Vector &&a)
    : elem{a.elem}, sz{a.sz} // grab the elements from a
{
  a.elem = nullptr; // now a has no elements
  a.sz = 0;
}

int main(int argc, char const *argv[]) { return 0; }
