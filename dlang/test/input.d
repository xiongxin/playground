module input;

import std.stdio;
import std.array;

int moduleVariable = 9;

class MyClass {
  int member;
}

void printHeader() {
  immutable dchar[] header =
    "                     Type of variable" ~
    "                      a == b  &a == &b";

  writeln();
  writeln(header);
  writeln(replicate("=", header.length));
}

void printInfo(const dchar[] lable, bool valueEquality, bool addressEquality) {
  writefln("%55s%9s%9s", lable, valueEquality, addressEquality);
}

void main(string[] args) {
  printHeader();

  int number1 = 12;
  int number2 = 12;
  printInfo("variables with equal values (value type)",
    number1 == number2,
    &number1 == &number2);

  int number3 = 3;
  printInfo("variables with different values (value type)",
    number1 == number3,
    &number1 == &number3);

  int[] slice = [4];
  foreach (i, ref element; slice) {
    printInfo("foreach with `ref` variable",
      element == slice[i],
      &element == &slice[i]);
  }

  outParameter(moduleVariable);
  refParameter(moduleVariable);
  inParameter(moduleVariable);

  int[] longSlice = [5, 6, 7];
  int[] slice1 = longSlice;
  int[] slice2 = slice1;
  printInfo("slices providing access to same elements",
    slice1 == slice2,
    &slice1 == &slice2);

  int[] slice3 = slice1[0 .. $ - 1];
  printInfo("slice providing access to different elements",
    slice1 == slice3,
    &slice1 == &slice3);

  auto variable1 = new MyClass;
  auto variable2 = variable1;
  printInfo("MyClass variables to same object (reference type)",
    variable1 == variable2,
    &variable1 == &variable2);

  auto variable3 = new MyClass;
  printInfo("MyClass variables to same object (reference type)",
    variable1 == variable3,
    &variable1 == &variable3);
}

void outParameter(out int parameter) {
  printInfo("function with `out` parameter",
    parameter == moduleVariable,
    &parameter == &moduleVariable);
}

void refParameter(ref int parameter) {
  printInfo("function with `ref` parameter",
    parameter == moduleVariable,
    &parameter == &moduleVariable);
}

void inParameter(in int parameter) {
  printInfo("function with `in` parameter",
    parameter == moduleVariable,
    &parameter == &moduleVariable);
}
