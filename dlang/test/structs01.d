module structs01;

struct Test {
  char c = 'A';
  int i = 11;
  double d = 0.25;
}

void main(string[] args) {
  auto t = new Test(
    'a', 1222, 22.23
  );
}
