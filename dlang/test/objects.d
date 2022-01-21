module objects;

import std.stdio;

class Clock {
  int hour;
  int minute;
  int second;

  this(int hour, int minute, int second) {
    this.hour = hour;
    this.minute = minute;
    this.second = second;
  }

  override size_t toHash() const @nogc @safe pure nothrow {
    return (3600 * hour) + (60 * minute) + second;
  }

  override bool opEquals(Object o) const {
    auto rhs = cast(const Clock) o;

    return (rhs &&
        (hour == rhs.hour) &&
        (minute == rhs.minute) &&
        (second == rhs.second));
  }
}

enum Color {
  blue,
  green,
  red
}

class Point {
  int x;
  int y;
  Color color;

  this(int x, int y, Color color) {
    this.x = x;
    this.y = y;
    this.color = color;
  }

  override bool opEquals(Object o) const {
    const(Point) rhs = cast(const Point) o;
    return rhs && x == rhs.x && y == rhs.y;
  }

  override int opCmp(Object o) const {
    /* Taking advantage of the automatically-maintained
         * order of the types. */
    if (typeid(this) != typeid(o)) {
      return typeid(this).opCmp(typeid(o));
    }

    const(Point) rhs = cast(const Point) o;
    /* No need to check whether rhs is null, because it is
         * known at this line that it has the same type as o. */
    if (x != rhs.x) {
      return x - rhs.x;
    }
    else if (y != rhs.y) {
      return y - rhs.y;
    }
    else {
      return 0;
    }
  }

  override size_t toHash() const @nogc @safe pure nothrow {
    return x + y;
  }
}

class TriangularArea {
  Point[3] points;

  this(Point one, Point two, Point three) {
    points = [one, two, three];
  }
}

void main(string[] args) {
  string[Clock] timeTags;
  timeTags[new Clock(12, 0, 0)] = "Noon";
  if (new Clock(12, 0, 0) in timeTags) {
    writeln("Exists");
  }
  else {
    writeln("Missing");
  }
  string name = "abc1";
  writeln(typeid(name).getHash(&name));

  // Different colors
  auto bluePoint = new Point(1, 2, Color.blue);
  auto greenPoint = new Point(1, 2, Color.green);

  // They are still equal
  assert(bluePoint == greenPoint);

  auto redPoint1 = new Point(-1, 10, Color.red);
  auto redPoint2 = new Point(-2, 10, Color.red);
  auto redPoint3 = new Point(-2, 7, Color.red);

  assert(redPoint1 < bluePoint);
  assert(redPoint3 < redPoint2);

  /* Even though blue is before green in enum Color,
     * because color is being ignored, bluePoint must not be
     * before greenPoint. */
  assert(!(bluePoint < greenPoint));
}
