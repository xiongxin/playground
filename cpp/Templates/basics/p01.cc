template <typename T> class Base {
public:
  void bar();
};

template <typename T> class Derived : Base<T> {
public:
  void foo() {
    this->bar(); // calls external bar() or error
  }
};

int main(int argc, char const *argv[]) {
  /* code */
  return 0;
}
