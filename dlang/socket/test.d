module test;

import std.stdio;

struct S {
  int a;
}

void main(string[] args) {
  S s;
  s.a = 1000;
  aa(&s);
  writeln(s);

  int[] a = [1, 23, 4];
  tt(a);
  tt(a[]);
}

void aa(S* s) {
  s.a = 100;
}

void tt(int[] a) {
  a[0] = 1000;
  writeln(a);
}
