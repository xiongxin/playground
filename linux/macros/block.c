#include <stdio.h>

#define DOUBLE(a) ((a) + (a))

int foo() {
  printf(__func__);
  return 3;
}

int main() { return DOUBLE(foo()); /* 呼叫 2 次 foo() */ }
