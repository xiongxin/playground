// list::begin
#include <iostream>
#include <list>

int main() {
  int myints[] = {75, 23, 65, 42, 13};
  const std::list<int> mylist{1, 2, 3};

  std::list<int>::iterator begin = mylist.begin();
  *begin = 22;

  // std::cout << "mylist contains:";
  // for (std::list<int>::iterator it = mylist.begin(); it != mylist.end();
  // ++it)
  //   std::cout << ' ' << *it;

  // std::cout << '\n';

  return 0;
}
