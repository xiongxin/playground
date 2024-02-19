#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char const *argv[]) {
  alarm(1);

  printf("OK!\n");
  while (1)
    ;

  return 0;
}
