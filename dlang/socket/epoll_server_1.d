module epoll_server_1;

import core.stdc.stdlib;
import core.sys.posix.unistd;
import core.sys.linux.epoll;
import core.stdc.string;
import std.stdio;

import std.string;

enum MAX_EVENTS = 5;
enum READ_SIZE = 10;

void main(string[] args) {

  epoll_event event;
  int epoll_fd = epoll_create1(0);
  if (epoll_fd == -1) {
    writeln("Failed to create epoll file descriptor\n");
    exit(1);
  }

  event.events = EPOLLIN;
  event.data.fd = 0;
  if (epoll_ctl(epoll_fd, EPOLL_CTL_ADD, 0, &event)) {
    writeln("Failed to add file descriptor to epoll\n");
    close(epoll_fd);
    exit(1);
  }

  int running = 1;
  int event_count;
  epoll_event[MAX_EVENTS] events;
  size_t bytes_read;
  char[READ_SIZE + 1] read_buffer;
  while (running) {
    writeln("Polling for input...");
    event_count = epoll_wait(epoll_fd, events.ptr, MAX_EVENTS, 30_000);
    writeln(event_count, " ready events");

    for (int i = 0; i < event_count; i++) {
      writeln("Reading file descriptor '", events[i].data.fd, "' --");
      bytes_read = read(events[i].data.fd, read_buffer.ptr, READ_SIZE);
      writeln(bytes_read, " bytes read");
      read_buffer[bytes_read] = '\0';
      writeln("Read '", fromStringz(read_buffer), "'");

      if (!strncmp(read_buffer.ptr, "stop\n", 5))
        running = 0;
    }
  }

  if (close(epoll_fd)) {
    writeln("Failed to add file descriptor to epoll\n");
    exit(1);
  }
}

unittest {
  assert(0);
}
