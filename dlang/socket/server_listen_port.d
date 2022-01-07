module server_listen_port;

import core.sys.posix.netdb;
import core.sys.posix.sys.types;
import core.sys.posix.sys.socket;
import core.stdc.string;
import core.stdc.stdlib;
import core.sys.posix.arpa.inet;
import core.sys.posix.netinet.in_;

import std.stdio;

void main(string[] args) {
  int status;
  addrinfo hits;
  addrinfo* servinfo;

  memset(&hits, 0, addrinfo.sizeof);

  hits.ai_family = AF_UNSPEC;
  hits.ai_socktype = SOCK_STREAM;
  hits.ai_flags = AI_PASSIVE;

  if ((status = getaddrinfo(null, "2341", &hits, &servinfo)) != 0) {
    writeln("getaddrinfo error:", gai_strerror(status));
    exit(1);
  }

  writeln(*servinfo.ai_addr);

  freeaddrinfo(servinfo);
}
