#include <iostream>

struct Address {
  const char *name;
  int number;
  const char *street;
  const char *town;
  char state[2];
  const char *zip;
};

void print_addr(Address *p) {
  std::cout << p->name << '\n'
            << p->number << ' ' << p->street << '\n'
            << p->town << '\n'
            << p->state[0] << p->state[1] << ' ' << p->zip << '\n';
}

int main(int argc, char const *argv[]) {

  Address jd = {"Jim Dandy",      61,         "South St",
                "New Providence", {'N', 'J'}, "07974"};
  print_addr(&jd);
  return 0;
}
