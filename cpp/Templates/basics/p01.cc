template <typename T1, typename T2>
auto max(T1 a, T2 b) -> decltype(b < a ? a : b) {
  return b < a ? a : b;
}

int main(int argc, char const *argv[]) {
  int a = 12;
  int b = 14;
  int c = ::max(a, b);
  return 0;
}
