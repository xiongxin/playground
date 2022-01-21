module templates1;

T[] removed(T)(const(T)[] slice, T value) {
  T[] result;

  foreach (element; slice) {
    if (element != value) {
      result ~= element;
    }
  }

  return result;
}

import std.stdio;

template isTooLarge(T) {
  enum isTooLarge = T.sizeof > 20;
}

void main(string[] args) {
  int[] a = [1, 2, 3];
  writeln(removed(a, 2));

  writeln(isTooLarge!int);
}
