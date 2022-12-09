#include <stdio.h>
#include <string.h>

#define WARN_IF(EXP)                                                           \
  do {                                                                         \
    if (EXP)                                                                   \
      fprintf(stderr, "Warning: " #EXP "\n");                                  \
  } while (0)

#define str(s) fprintf(stdout, s)
#define foo 4

int main(int argc, char const *argv[]) {
  int x = 0;
  char p[] = "foo\n";
  WARN_IF(strcmp(p, "foo\n") == 0);
  str(foo);
  return 0;
}
