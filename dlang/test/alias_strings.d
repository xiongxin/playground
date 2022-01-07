module alias_strings;

import std.stdio;
import std.utf;

void main(string[] args) {
  auto str = "这是🍞中🚗文😂濼鳢🌍";
  writeln(char.sizeof);
  writeln(str.byUTF!wchar());
  foreach (s; byDchar(str)) {
    writeln(s);
  }
}
