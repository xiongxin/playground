module select_1;

import core.sys.posix.sys.time;
import core.sys.posix.sys.types;
import core.sys.posix.unistd;

import std.stdio;

enum STDIN = 0; // file descriptor for standard input

void main(string[] args) {
  timeval tv = {2, 500_000};
  fd_set readfds;

  FD_ZERO(&readfds);
  FD_SET(STDIN, &readfds);

  // don't care about writefds and exceptfds:
  select(STDIN + 1, &readfds, null, null, &tv);

  if (FD_ISSET(STDIN, &readfds)) {
    writeln("A key was pressed!");
  }
  else {
    writeln("Timed out.");
  }
}
