#include <dlfcn.h>
#include <stddef.h>
#include <stdio.h>
#include <string.h>

void *malloc(size_t size) {
  char buf[32];
  static void *(*real_malloc)(size_t) = NULL;
  if (real_malloc == NULL) {
    // Find the run-time address in the shared object HANDLE refers to
    // of the symbol called NAME.
    real_malloc = dlsym(RTLD_NEXT, "malloc");
  }
  sprintf(buf, "malloc called, size = %zu\n", size);
  write(2, buf, strlen(buf));
  return real_malloc(size);
}

/**
 * gcc -D_GNU_SOURCE -shared -ldl -fPIC -o /tmp/libmcount.so malloc_count.c
 * LD_PRELOAD=/tmp/libmcount.so ls
 */
