module foreachs;

import std.stdio;
import std.range;

struct NumberRange {
  int begin;
  int end;

  invariant () {
    assert(begin <= end);
  }

  bool empty() const {
    return begin == end;
  }

  void popFront() {
    ++begin;
  }

  int front() const {
    return begin;
  }
}

void main(string[] args) {
  auto s = "这是一行中文12";
  foreach (c; stride(s, 2)) {
    writeln(c);
  }

  foreach (e; NumberRange(3, 7)) {
    write(e, ' ');
  }
  writeln();
}
