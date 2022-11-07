#include <iostream>
#include <signal.h>
#include <unistd.h>

void sigint_handler(int signum) { std::cout << "got SIGINT\n"; }

int main(int argc, char const *argv[]) {
  signal(SIGINT, sigint_handler);
  std::cout << "pid is " << getpid() << "\n";
  while (1) {
    sleep(1);
  }

  return 0;
}
