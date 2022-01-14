module a;

import std.stdio;
import std.socket;

void main(string[] args) {
  writeln("About www.163.com port 80:");
  try {
    Address[] addresses = getAddress("www.baidu.com", 80);
    writefln("  %d addresses found.", addresses.length);
    foreach (int i, Address a; addresses) {
      writefln("  Address %d:", i + 1);
      writefln("    IP address: %s", a.toAddrString());
      writefln("    Hostname: %s", a.toHostNameString());
      writefln("    Port: %s", a.toPortString());
      writefln("    Service name: %s",
        a.toServiceNameString());
    }
  }
  catch (SocketException e)
    writefln("  Lookup error: %s", e.msg);
}
