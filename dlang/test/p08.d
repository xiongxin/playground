module p08;

import std.stdio;

bool lessThan(int a, int b) {
  writeln("unsafe world"); // output can throw exceptions, thus this is forbidden
  return a < b;
}

void main(string[] args) {
  int i = 1;
  int b = i = 100;
  writeln(i = 100, " ", b);

  int[2] a = [1, 23];
  writeln(typeof(a).stringof, " ", typeof(a[]).stringof);

  foreach (v; 0 .. 10) {
    writeln(v);
  }

  writeln(typeof(lessThan).stringof, " ", typeof(&lessThan).stringof, " ", typeof(() => 2).stringof);
}
