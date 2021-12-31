module array;

import std.stdio;

void main(string[] args)
{
  double[] array = [1.25, 3.75];
  double[] theCopy = array.dup;

  int[] slice = [1, 3, 5, 7, 9, 11, 13, 15];
  int[] half = slice[0 .. $ / 2];
  int[] quarter = slice[0 .. $ / 4];
  writefln("slice's capacity = %d, slice'length = %d", slice.capacity, slice.length);
  quarter[1] = 0;

  quarter ~= 42;

  writeln(quarter);
  writeln(half);
  writeln(slice);
  writeln("==========");
  // Three slices to all elements
  int[] s0 = [1, 2, 3, 4];
  int[] s1 = s0;
  int[] s2 = s0;
  writeln("==========");
  writeln(s0);
  writeln(s1);
  writeln(s2);
  writeln(s0.capacity);
  writeln(s1.capacity);
  writeln(s2.capacity);

  writeln("==========");

  s1 ~= 42;
  s0[1] = 99;
  s0 ~= 1;

  writeln(s0);
  writeln(s1);
  writeln(s2);
  writeln(s0.capacity);
  writeln(s1.capacity);
  writeln(s2.capacity);

  writeln("==========");
  int[] slice1;

  slice1.reserve(20);
  writeln(slice1.capacity);

  foreach (element; 0 .. 17)
  {
    slice1 ~= element; // ← these elements will not be moved
  }

  writeln(slice1.capacity);
}
