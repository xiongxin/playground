module special_functions2;

import std.stdio;
import std.array;
import std.conv;
import std.random;

class Test {
  static Test opCall() {
    writeln("A Test object is being constructed.");
    Test test = new Test;
    writeln(test);
    return test;
  }
}

void main(string[] args) {
  auto test = Test();
  writeln(test);
}
