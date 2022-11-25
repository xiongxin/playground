#include <cstdlib>
#include <sys/mman.h>

struct node_t {
  int size;
  struct node_t *next;
};

int main(int argc, char const *argv[]) {
  node_t *head = static_cast<node_t *>(
      mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE, -1, 0));

  return 0;
}
