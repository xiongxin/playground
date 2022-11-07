#include <inttypes.h>
#include <stdio.h>

int main() {
  uint32_t le = 0x12345678;
  uint32_t be = __builtin_bswap32(le);

  printf("Little-endian: 0x%" PRIx32 "\n", le);
  printf("Big-endian:    0x%" PRIx32 "\n", be);

  return 0;
}
