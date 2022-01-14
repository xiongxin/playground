module showip;

import core.sys.posix.netdb;
import core.sys.posix.sys.types;
import core.sys.posix.sys.socket;
import core.stdc.string;
import core.stdc.stdlib;
import core.sys.posix.arpa.inet;
import core.sys.posix.netinet.in_;

import std.stdio;
import std.string;

void main(string[] args) {
  addrinfo hints;
  addrinfo* res;
  addrinfo* p;
  int status;
  char[INET6_ADDRSTRLEN] ipstr;

  memset(&hints, 0, hints.sizeof);
  hints.ai_family = AF_UNSPEC;
  hints.ai_socktype = SOCK_STREAM;
  hints.ai_flags = AI_CANONNAME;

  if ((status = getaddrinfo(cast(char*) args[1], null, &hints, &res)) != 0) {
    writeln("getaddinfo: ", gai_strerror(status));
    exit(2);
  }

  writeln("IP addresses for ", args[1]);

  for (p = res; p != null; p = p.ai_next) {
    void* addr;
    char* ipver;
    if (p.ai_family == AF_INET) {
      auto ipv4 = cast(sockaddr_in*) p.ai_addr;
      addr = &(ipv4.sin_addr);
      ipver = cast(char*) "IPv4";
    }
    else {
      auto ipv6 = cast(sockaddr_in6*) p.ai_addr;
      addr = &(ipv6.sin6_addr);
      ipver = cast(char*) "IPv6";
    }

    inet_ntop(p.ai_family, addr, cast(char*) ipstr, ipstr.sizeof);
    writefln("   %s: %s %s", fromStringz(ipver), fromStringz(ipstr), fromStringz(p.ai_canonname));

  }

  freeaddrinfo(res);
}
