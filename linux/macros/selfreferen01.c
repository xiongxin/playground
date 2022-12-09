int x = 1;

#define x (4 + y)
#define y (2 * x)

int main(int argc, char const *argv[]) {
  int b = x;

  return 0;
}
