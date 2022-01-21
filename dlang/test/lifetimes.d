module lifetimes;

import std.stdio;

void main(string[] args) {
  int p_out = 100;
  foo(p_out);
  writeln(p_out);

  P p1 = new P(12);
  P p2 = p1;
}

void foo(out int p_out) {
  writeln(p_out);
  p_out = 200;
}

class P {
  int a;

  this(int a) {
    this.a = a;
  }

  ~this() {
    writeln("P~this()");
  }
}
