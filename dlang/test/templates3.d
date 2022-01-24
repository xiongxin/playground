module templates3;

import std.stdio;

template isTooLarge(T) {
  enum isTooLarge = T.sizeof > 20;
}

template LargerOf(A, B) {
  static if (A.sizeof < B.sizeof) {
    alias LargerOf = B;
  }
  else {
    alias LargerOf = A;
  }
}

class Sink {
  string content;

  void put(T)(auto ref const T value) {
    import std.conv;

    content ~= to!string(value);
  }
}

union SegmentedValue(ActualT, SegmentT) {
  ActualT value;
  SegmentT[segmentCount!(ActualT, SegmentT)] segments;
}

template segmentCount(ActualT, SegmentT) {
  enum segmentCount = ((ActualT.sizeof + (SegmentT.sizeof - 1)) / SegmentT.sizeof);
}

// interface template

interface ColoredObject(ColorT) {
  void paint(ColorT colore);
}

struct RGB {
  ubyte red;
  ubyte green;
  ubyte blue;
}

class PageFrame : ColoredObject!RGB {
  void paint(RGB color) {
  }
}

alias Frequency = double;

class Bulb : ColoredObject!Frequency {
  void paint(Frequency color) {
  }
}

class Point {
}

struct Polygon(size_t N) {
  Point[N] corners;
}

struct MyStruct(T) {
  void foo(this OwnType)() const {
    writeln("Type of this object: ", OwnType.stringof);
  }
}

struct MyStruct1(alias variable) {
  void set(int value) {
    variable = value;
  }
}

void caller(alias func)() {
  write("calling: ");
  func();
}

void foo() {
  writeln("foo called.");
}

void bar() {
  writeln("bar called.");
}

void info(T...)(T args) {
  foreach (i, arg; T) {
    // writefln("1 %s : %s argument %s", i, typeof(arg).stringof, arg);
    writefln("2 %s : %s argument", i, arg.stringof);
  }
}

void main(string[] args) {
  writeln(isTooLarge!int);

  auto address = SegmentedValue!(uint, ubyte)(0xc0a80102);
  writeln(address.value);
  foreach (octet; address.segments) {
    write(octet, ' ');
  }
  writeln();
  auto m = MyStruct!int();
  m.foo();

  int x = 1;
  int y = 2;
  auto object = MyStruct1!x();

  object.set(100);
  writeln("x = ", x);

  caller!foo();
  caller!bar();

  info(1, "aaa", 22.2);
}
