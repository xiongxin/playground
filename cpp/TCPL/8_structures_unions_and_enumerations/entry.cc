#include <iostream>

enum Type { str, num };

union Value {
  const char *s;
  int i;
};

struct Entry {
  const char *name;
  Type t;
  Value v;
};

void f(Entry *p) {
  if (p->t == str)
    std::cout << p->v.s;
  else
    std::cout << p->v.i;
}

int main(int argc, char const *argv[]) {
  Entry e{"e1", str, "this is a str"};
  f(&e);
  return 0;
}
