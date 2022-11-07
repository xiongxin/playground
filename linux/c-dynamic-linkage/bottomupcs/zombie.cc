#include <iostream>
#include <unistd.h>

int main() {
  std::cout << getpid() << std::endl;

  pid_t pid = fork();

  if (pid == 0) {
    std::cout << "child: " << getpid() << std::endl;
    sleep(2);
    std::cout << "child exit\n";
    exit(1);
  }

  /*in parent */
  while (1) {
    sleep(1);
  }

  return 0;
}
