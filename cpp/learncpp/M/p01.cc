#include <iostream>

class Resource {};

void someFunction() {
  Resource* ptr = new Resource();

  int x = 0;

  if (x == 0) throw 0;  // the function returns early, and ptr won’t be deleted!

  // do stuff with ptr here

  delete ptr;
}

int main() {
  someFunction();
  return 0;
}
