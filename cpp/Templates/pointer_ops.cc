#include <iostream>
#include <string>

using namespace std;

struct MyString {
  string* s;

  string* operator->() { return s; }
};

int main(int argc, char const* argv[]) {
  MyString ms{new string{"abc"}};

  int a = ms->size();
  return 0;
}
