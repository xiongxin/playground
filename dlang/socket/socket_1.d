module socket_1;

import core.sys.posix.netdb;
import core.sys.posix.sys.types;
import core.sys.posix.sys.socket;
import core.stdc.string;
import core.stdc.stdlib;
import core.sys.posix.arpa.inet;
import core.sys.posix.netinet.in_;

import std.stdio;
import std.string;

enum MYPORT = "3049";
enum BACKLOG = 10;

void main(string[] args) {
  addrinfo hints;
  addrinfo* res;

  // first, load up address structs with getaddrinfo():

  memset(&hints, 0, hints.sizeof);
  hints.ai_family = AF_UNSPEC; // use IPv4 or IPv6, whichever
  hints.ai_socktype = SOCK_STREAM;
  hints.ai_flags = AI_PASSIVE; // fill in my IP for me

  getaddrinfo(null, MYPORT, &hints, &res);

  // make a socket:

  int sockfd = socket(res.ai_family, res.ai_socktype, res.ai_protocol);

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
