module slices;

import std.stdio;

void main() {
  int[] slice = [1, 3, 5, 7, 9, 11, 13, 15];
  int[] half = slice[0 .. $ / 2];
  int[] quarter = slice[0 .. $ / 4];

  quarter[1] = 0; // modify through one slice

  writeln(quarter);
  writeln(half);
  writeln(slice);
  writeln("===================");
  quarter ~= 42;

  writeln(quarter);
  writeln(half);
  writeln(slice);

  writeln("===================");
  int[] a = [1, 11, 111];
  int[] d = a;

  d = d[1 .. $]; // shortening from the beginning
  d[0] = 42; // modifying the element through the slice

  writeln(a); // printing the other slice
  writeln(d);
  writeln("===================");

  writeln("=========Using capacity to determine whether sharing will be terminated==========");

  // Three slices to all elements
  int[] s0 = [1, 2, 3, 4];
  int[] s1 = s0;
  int[] s2 = s0;

  s1 ~= 31;
  s1[0] = 100;
  writeln(s0);
  writeln(s1);
  writeln(s2);
  writeln(uint.sizeof);
  writeln(uint.max);
}
