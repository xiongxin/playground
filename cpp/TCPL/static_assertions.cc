
constexpr double C = 299792.458;

void f(double speed) {
  constexpr double local_max = 160.0 / (60 * 60);

  static_assert(local_max < C, "can't go that fast");
}

int main(int argc, char const *argv[]) { return 0; }
