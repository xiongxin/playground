module tuples;

import std.stdio;
import std.typecons;
import std.meta;

void foo(int i, string s, double d) {
  writefln("foo is called with %s, %s, and %s.", i, s, d);
}

void main(string[] args) {
  auto t = Tuple!(int, "number", string, "message")(42, "hello");

  writeln("by index 0    : ", t[0]);
  writeln("by .number 0  : ", t.number);
  writeln("by index 1    : ", t[1]);
  writeln("by .message 1 : ", t.message);

  alias arguments = AliasSeq!(1, "hello", 2.5);
  foo(arguments);

  string[string] dictionary;
  dictionary["a"] = "a1";
  dictionary["b"] = "b1";

  writeln(dictionary);
}
