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

struct NumberRange2 {
  int begin;
  int end;

  int opApply(int delegate(ref int) operations) const {
    int result = 0;

    for (int number = begin; number != end; ++number) {
      result = operations(number);
      writeln("result = ", result);
      if (result)
        break;
    }

    return result;
  }
}

void main(string[] args) {
  auto s = "这是一行中文12";
  foreach (c; stride(s, 1)) {
    writeln(c);
  }

  foreach (e; NumberRange(3, 7)) {
    write(e, ' ');
  }
  writeln();

  foreach (element; NumberRange2(3, 7)) {
    write(element, ' ');
  }
}
