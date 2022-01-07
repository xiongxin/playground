import core.sys.posix.netdb;
import core.sys.posix.sys.types;
import core.sys.posix.sys.socket;

import std.stdio;

void main(string[] args) {
  sockaddr_in sa;
  sockaddr_in6 sa6;

  auto r1 = inet_pton(AF_INET, "1aa0.12.110.57x", &(sa.sin_addr));
  writeln("r1 = ", r1);
  inet_pton(AF_INET6, "2001:db8:63b3:1::3490", &(sa6.sin6_addr));
  writeln(sa);
  writeln(sa6);

  char[INET_ADDRSTRLEN] ip4;
  sockaddr_in sa1;
  inet_ntop(AF_INET, &(sa1.sin_addr), cast(char*) ip4, INET_ADDRSTRLEN);
  writeln("The IPv4 address is ", ip4);

  char[INET6_ADDRSTRLEN] ip6;
  sockaddr_in6 sa2;
  inet_ntop(AF_INET6, &(sa2.sin6_addr), cast(char*) ip6, INET6_ADDRSTRLEN);
  writeln("The IPv6 address is ", ip6);
}
