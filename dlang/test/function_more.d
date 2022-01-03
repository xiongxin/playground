module function_more;

import std.stdio;

ref int greater(return ref int first, return ref int second) {
  return first > second ? first : second;
}

void main() {
  int a = 1;
  int b = 2;
  int result = greater(a, b);
  result += 10; // ← neither a nor b changes
  writefln("a: %s, b: %s, result: %s", a, b, result);
}
