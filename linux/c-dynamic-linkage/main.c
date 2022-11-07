#include <stdio.h>

/**
 *
 * gcc -fvisibility=hidden -shared -fPIC  -o  liblibrary.so file1.c file2.c
 * gcc main.c -L. -llibrary -o sample
 * export
 * LD_LIBRARY_PATH=/home/xiongxin/Data/Code/playground/linux/c-dynamic-linkage:$LD_LIBRARY_PATH
 * ./sample
 *
 */

extern void api_function(void);
extern void common_but_not_part_of_api(void);

int main(int argc, char const *argv[]) {
  api_function();
  common_but_not_part_of_api();
  return 0;
}
