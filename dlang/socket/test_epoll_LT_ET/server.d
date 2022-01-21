import std.stdio;
import core.sys.posix.unistd;
import core.sys.posix.netdb;
import core.stdc.string;
import core.stdc.stdlib;
import std.conv;
import core.sys.linux.epoll;
import core.sys.posix.fcntl;
import core.stdc.errno;

import std.algorithm;

int do_listen() {
  addrinfo ai_hints;
  addrinfo* ai_list;

  memset(&ai_hints, 0, ai_hints.sizeof);

  ai_hints.ai_family = AF_INET;
  ai_hints.ai_socktype = SOCK_STREAM;
  ai_hints.ai_protocol = IPPROTO_TCP;

  int status = getaddrinfo(null, "8001", &ai_hints, &ai_list);
  if (status != 0) {
    return -1;
  }

  int fd = socket(ai_list.ai_family, ai_list.ai_socktype, 0);
  if (fd < 0) {
    freeaddrinfo(ai_list);
    return -1;
  }
  int yes = 1;
  setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &yes, yes.sizeof);
  status = bind(fd, cast(sockaddr*) ai_list.ai_addr, ai_list.ai_addrlen);
  if (status != 0) {
    close(fd);
    freeaddrinfo(ai_list);
    return -1;
  }

  listen(fd, 30);

  writeln("do_listen success fd: ", fd);
  return fd;
}

void main(string[] args) {
  if (args.length < 2) {
    writeln("please input mode, lt or et");
    exit(-1);
  }

  int ep_event = 0;
  if (cmp(args[1], "et") == 0) {
    ep_event = EPOLLET;
  }

  int epfd = epoll_create(1024);
  if (epfd == -1) {
    writeln("fail to create epoll ", strerror(errno));
    exit(-1);
  }

  int listen_fd = do_listen();
  if (listen_fd < 0) {
    writeln("do listen fail");
    exit(-1);
  }

  epoll_event ee;
  ee.events = EPOLLIN;
  ee.data.fd = listen_fd;
  epoll_ctl(epfd, EPOLL_CTL_ADD, listen_fd, &ee);

  while (true) {
    writeln("before epoll epoll_wait");
    epoll_event[16] ev;
    int n = epoll_wait(epfd, ev.ptr, 16, -1);
    if (n == -1) {
      writeln("epoll_wait error ", strerror(errno));
      break;
    }

    writeln("after epoll_wait event n=", n);

    for (int i = 0; i < n; i++) {
      epoll_event* e = &ev[i];
      writeln("event: ", ev[i]);
      if (e.data.fd == listen_fd) {
        sockaddr s;
        socklen_t len = s.sizeof;
        int client_fd = accept(listen_fd, &s, &len);
        if (client_fd < 0) {
          writeln("accpet client fd error ", errno, " ", strerror(errno));
          break;
        }

        fcntl(client_fd, F_SETFL, O_NONBLOCK);
        ee.events = EPOLLIN | ep_event;
        ee.data.fd = client_fd;

        epoll_ctl(epfd, EPOLL_CTL_ADD, client_fd, &ee);
        writeln("accept new connection fd:", client_fd);
      }
      else {
        int client_fd = e.data.fd;
        int flag = e.events;
        int r = (flag & EPOLLIN) != 0;

        if (r) {
          writeln("read fd:", client_fd);
          char[2] buffer;
          n = cast(int) read(client_fd, buffer.ptr, 2);
          writeln("read number ", n);
          if (n < 0) {
            switch (errno) {
            case EINTR:
              break;
            case EWOULDBLOCK:
              break;
            default:
              break;
            }
          }
          else if (n == 0) {
            epoll_ctl(epfd, EPOLL_CTL_DEL, client_fd, null);
            close(client_fd);
            break;
          }
          else {
            writefln("%s", buffer);
          }
        }
      }
    }
  }
}
