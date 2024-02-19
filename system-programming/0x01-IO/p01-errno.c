
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>

int main() {

  FILE *fp = fopen("const", "r");

  if (errno != 0) {
    fprintf(stderr, "error is %d\n", errno);
  }

  return 0;
}
