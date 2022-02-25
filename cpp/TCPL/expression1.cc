#include <cstring>
#include <iostream>
#include <string>

using namespace std;

void f(string &s1, string &s2, string &s3) {
  const char *cs = (s1 + s2).c_str();
  cout << cs;
  if (strlen(cs = (s2 + s3).c_str()) < 8 && cs[0] == 'a') {
  }
}

int main(int argc, char const *argv[]) {
  int i = 1 / 0;
  return 0;
}
