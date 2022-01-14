module poll_1;

import core.stdc.stdio;
import core.sys.posix.poll;

void main(string[] args) {
  pollfd[1] pfds; // more if you want to monitior more
  pfds[0].fd = 0; // standard input
  pfds[0].events = POLLIN; // tell new when ready to read

  printf("Hit RETURN or wait 2.5 seconds for timeout\n");

  int num_events = poll(cast(pollfd*) pfds, 1, 2500);
  if (num_events == 0) {
    printf("Poll timed out!\n");
  }
  else {
    int pollin_happened = pfds[0].revents & POLLIN;

    if (pollin_happened) {
      printf("File descriptor %d is ready to read\n", pfds[0].fd);
    }
    else {
      printf("Unexpected event occurred: %d\n", pfds[0].revents);
    }
  }
}
