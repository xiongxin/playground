#define FOO(x, ...)                                                            \
  x;                                                                           \
  FOO(__VA_ARGS__)

FOO(1, 2, 3);
