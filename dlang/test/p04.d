module p04;

import std.stdio;
import std.conv;

void main(string[] args)
{
  immutable int[] slice = [1, 2, 3];
  print(slice);
  foo(slice);
}

void print(const int[] slice)
{
  writefln("%s element", slice);

  foreach (i, element; slice)
  {
    writefln("%s: %s", i, element);
  }
}
// const 包括 immutable 和 mutable
// void foo(const int[] slice)
// {
//   bar(slice.idup); // immutable copy of the slice
// }

void bar(immutable int[] slice)
{

}

/* Because it is a template, foo() can be called with both mutable
 * and immutable variables. */
void foo(T)(T[] slice)
{
  /* 'to()' does not make a copy if the original variable is
     * already immutable. */
  bar(to!(immutable T[])(slice));
}
