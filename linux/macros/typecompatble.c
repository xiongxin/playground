#include <stdio.h>
#include <string.h>

#define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
#define MULTICHAR_CONSTANT(a, b, c, d)                                         \
  ((int32_t)((a) | (b) << 8 | (c) << 16 | (d) << 24))
int main(int argc, char const *argv[]) {
  int a[10];
  int *a_ptr = a;
  int c = __same_type(a, &a[0]);
  printf("%d\n", c);

  // switch (*((int32_t *)(s)) | 0x20202020)

  char *css = "a.css";
  printf("%d\n", (*((int *)(strrchr(css, '.'))) | 0x20202020));
  printf("%d\n", MULTICHAR_CONSTANT_L('.', 'c', 's', 's'));

  return 0;
}
