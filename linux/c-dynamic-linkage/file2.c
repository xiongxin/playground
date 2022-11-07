extern void common_but_not_part_of_api(void);

void __attribute__((visibility("default"))) api_function(void) {
  common_but_not_part_of_api();
}
