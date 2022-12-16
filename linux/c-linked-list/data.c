#include <stddef.h>
#include <stdio.h>

struct data {
  short a;
  char b;
  double c;
};

int main() {
  struct data x = {.a = 25, .b = 'A', .c = 12.45};

  char *p = (char *)&x;
  printf("a=%d\n", *((short *)p));

  p = (char *)&x + offsetof(struct data, b);
  printf("b=%c\n", *((char *)p));

  p = (char *)&x + offsetof(struct data, c);
  printf("p=%p, &x.c=%p\n", p, &(x.c));
  printf("c=%lf\n", *((double *)p));
  return 0;
}
