module null_is;

import std.stdio;

class MyClass {
  int member;
}

void use(MyClass variable) {
  writeln(variable.member);
}

void main(string[] args) {
  MyClass variable;
  use(variable);
}
