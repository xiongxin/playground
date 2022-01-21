module unions;

union IpAddress {
  uint value;
  ubyte[4] bytes;
}

import std.stdio;

void main(string[] args) {
  auto address = IpAddress(3232235778);
  writeln(address.bytes);
  writeln(address.value);
}
