module characters;

import std.stdio;
import std.string;

void main() {
  string a_slice = "hello";

  char** a;
  auto b = 'a';
  writeln(&b);
  auto c = &b;
  writeln(c);
  a = &c;
  writeln(a);
  writeln(*a);
  writeln(**a);
}
