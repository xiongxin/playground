module socket_2;

import core.sys.posix.netdb;
import core.sys.posix.sys.types;
import core.sys.posix.sys.socket;
import core.stdc.string;
import core.stdc.stdlib;
import core.sys.posix.arpa.inet;
import core.sys.posix.netinet.in_;
import core.sys.posix.signal;
import core.stdc.errno;
import core.sys.posix.sys.wait;

import std.stdio;
import std.string;

enum MYPORT = "3049";
enum BACKLOG = 10;

void sigchld_handler(int s) {
  // waitpid() might overwrite errno, so we save and restore it
  int saved_error = errno;
  while (waitpid(-1, null, WNOHANG) > 0) {
  }

  errno = saved_error;
}

void* get_in_addr(sockaddr* sa) {
  if (sa.sa_family == AF_INET) {
    sockaddr_in* si = cast(sockaddr_in*) sa;
    return cast(void*)&si.sin_addr;
  }

  sockaddr_in6* si = cast(sockaddr_in6*) sa;
  return cast(void*)&si.sin6_addr;
}

void main(string[] args) {
  addrinfo hints;
  addrinfo* res;

  // first, load up address structs with getaddrinfo():

  memset(&hints, 0, hints.sizeof);
  hints.ai_family = AF_UNSPEC; // use IPv4 or IPv6, whichever
  hints.ai_socktype = SOCK_STREAM;
  hints.ai_flags = AI_PASSIVE; // fill in my IP for me

  getaddrinfo(null, MYPORT, &hints, &res);

  // loop through all the results and bind to the first we can
  addrinfo* p;
  int sockfd;
  int yes = 1;
  for (p = res; p != null; p = p.ai_next) {
    if ((sockfd = socket(p.ai_family, p.ai_socktype, p.ai_protocol)) == -1) {
      perror("server: socket");
      continue;
    }

    if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &yes, yes.sizeof) == -1) {
      perror("setsockopt");
      exit(1);
    }

    if (bind(sockfd, p.ai_addr, p.ai_addrlen) == -1) {
      close(sockfd);
      perror("server: bind");
      continue;
    }

    break;
  }

  freeaddrinfo(res); // all done with this structre

  if (p == null) {
    fprintf(stderr, "server: failed to bind\n");
    exit(1);
  }

  if (listen(sockfd, BACKLOG) == -1) {
    perror(listen);
    exit(1);
  }

  sigaction_t sa;
  sa.sa_handler = sigchld_handler;
  sigemptyset(&sa.sa_mask);
  if (sigaction(SIGCHLD, &sa, null) == -1) {
    perror("sigaction");
    exit(1);
  }

  printf("server: waiting for connections...\n");

  // int sockfd = socket(res.ai_family, res.ai_socktype, res.ai_protocol);

  // bind it to the port we passed in to getaddreinfo()

  bind(sockfd, res.ai_addr, res.ai_addrlen);
  listen(sockfd, BACKLOG);

  // now accept an incoming connection:
  sockaddr_storage their_addr;
  int newfd = accept(sockfd, cast(sockaddr*)&their_addr, their_addr.sizeof);

  // ready to communicate on socket descriptor newfd

  auto msg = "Beej was here!";
  auto bytes_send = send(newfd, msg, msg.length, 0);
}
