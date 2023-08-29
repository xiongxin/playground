class C {
public:
  template <typename T> C(T const &) { std::cout << "tmpl copy constructor\n"; }
};

int main(int argc, char const *argv[]) {
  C x;
  C y{x};
  return 0;
}
