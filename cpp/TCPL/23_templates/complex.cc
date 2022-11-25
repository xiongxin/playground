template <typename Scalar> class complex {
  Scalar re, im;

public:
  complex() : re{}, im{} {}
  template <typename T> complex(T rr, T ii = 0) : re{rr}, im{ii} {}
  // default constructor
  complex(const complex &) = default;
  // copy constructor
  template <typename T>
  complex(const complex<T> &c) : re{c.real()}, im{c.imag()} {}
  // ...
};

int main(int argc, char const *argv[]) {
  complex<float> cf;
  complex<double> cd{cf};
  complex<float> cf2{cd};
  // default value
  // OK: uses float to double conversion
  // error : no implicit double->float conversion
  complex<float> cf3{2.0, 3.0};
  // error : no implicit double->float conversion
  complex<double> cd2{2.0F, 3.0F}; // OK: uses float to double conversion
  return 0;
}
