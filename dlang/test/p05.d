module p05;

import std.stdio;
import std.string;
import std.algorithm;

void makeFirstLetterDot(dchar[] str)
{
  str[0] = '.';
}

void main()
{
  dchar[] str = "abc"d.dup; //.dup;
  makeFirstLetterDot(str);
  writeln(str);
}

void print(string title, int[] slice)
{
  writeln(title, ":");

  foreach (i, element; slice)
  {
    writefln("%3s:%5s", i, element);
  }
}

int readInt(string message)
{
  int result;
  write(message, "? ");
  readf(" %s", &result);

  return result;
}

int[] readNumbers()
{
  int[] result;
  int count = readInt("How many numbers are you going to enter");

  foreach (i; 0 .. count)
  {
    result ~= readInt(format("Number %s", i));
  }

  return result;
}
