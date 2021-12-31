import std.stdio;

void main(string[] args)
{
  int i;
  immutable(int) imm;
  auto arr = [1];
  auto aa = [10: "ten"];

  /* All of the following arguments are lvalues. */

  writeln(i, // mutable variable
    imm, // immutable variable
    arr, // array
    arr[0], // array element
    aa[10]); // associative array element
  // etc.

  enum message = "hello";

  writeln(42, message, i + 1, calculate(i + 1));
}

int calculate()(auto ref int i)
{
  return i * 2;
}
