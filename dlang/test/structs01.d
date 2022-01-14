module structs01;

struct Test {
  char c = 'A';
  int i = 11;
  double d = 0.25;

  this(this) {
  }
}

void main(string[] args) {
  auto t = Test(
    'a', 1222, 22.23
  );

  auto t1 = t.dup;
}
