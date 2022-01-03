module const_member_functions;

import std.string;
import std.stdio;

struct TimeOfDay {
  int hour;
  int minute;

  string toString() const {
    return format("%02s:%02s", hour, minute);
  }
}

void main(string[] args) {
  auto start = TimeOfDay(5, 30);
  writeln(start);

  {
    // An immutable container
    auto container = immutable(Container)([1, 2, 3]);
    auto slice = container.firstPart(2);
    writeln(typeof(slice).stringof);
  }

  {
    // A const container
    auto container = const(Container)([1, 2, 3]);
    auto slice = container.firstPart(2);
    writeln(typeof(slice).stringof);
  }
  {
    // A mutable container
    auto container = Container([1, 2, 3]);
    auto slice = container.firstPart(2);
    writeln(typeof(slice).stringof);
  }
}

struct Container {
  int[] elements;

  inout(int)[] firstPart(size_t n) {
    return elements[0 .. n];
  }
}
