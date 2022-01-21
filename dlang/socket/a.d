module a;

import std.stdio;
import std.socket;
import std.conv;
import core.sys.linux.epoll;
import core.stdc.errno;

void main(string[] args) {
  // writeln("About www.163.com port 80:");
  // try {
  //   Address[] addresses = getAddress("www.baidu.com", 80);
  //   writefln("  %d addresses found.", addresses.length);
  //   foreach (int i, Address a; addresses) {
  //     writefln("  Address %d:", i + 1);
  //     writefln("    IP address: %s", a.toAddrString());
  //     writefln("    Hostname: %s", a.toHostNameString());
  //     writefln("    Port: %s", a.toPortString());
  //     writefln("    Service name: %s",
  //       a.toServiceNameString());
  //   }
  // }
  // catch (SocketException e)
  //   writefln("  Lookup error: %s", e.msg);

  writeln(!-1);
  writeln(!0);
  writeln(!1);
  writeln(toChars(1000));
  errno = 100;
  writeln(errno);
  writeln(EPOLLET);
  writeln(EPOLLET | EPOLLIN);
}
