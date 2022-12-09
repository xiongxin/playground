template <typename T> T max(T const &a, T const &b) { return b < a ? a : b; }

int main(int argc, char const *argv[]) {
  ::max(1, 2);
  return 0;
}
