module operator_overloading;

import std.stdio;
import std.random;
import std.string;

struct Duration {
  int minute;
}

struct TimeOfDay {
  int hour;
  int minute;

  void increment(Duration duration) {
    minute += duration.minute;

    hour += minute / 60;
    minute %= 60;
    hour %= 24;
  }

  ref TimeOfDay opOpAssign(string op)(Duration duration) if (op == "+") {
    minute += duration.minute;

    hour += minute / 60;
    minute %= 60;
    hour %= 24;

    return this;
  }

  ref TimeOfDay opUnary(string op)() if (op == "++") {
    ++minute;
    return this;
  }

  int opCmp(TimeOfDay rhs) const {
    return hour == rhs.hour ? minute - rhs.minute : hour - rhs.hour;
  }

  string toString() const {
    return format("%02s:%02s", hour, minute);
  }
}

struct LinearEquation {
  double a;
  double b;

  double opCall(double x) const {
    return a * x + b;
  }
}

void main(string[] args) {
  auto lunchTime = TimeOfDay(12, 0);
  writeln(lunchTime);
  lunchTime += Duration(10);
  writeln(lunchTime);
  writeln(lunchTime++);
  writeln(lunchTime);

  TimeOfDay[] times;
  foreach (i; 0 .. 10) {
    times ~= TimeOfDay(uniform(0, 24), uniform(0, 60));
  }

  import std.algorithm;

  sort(times);

  writeln(times);

  LinearEquation equation = {1.2, 3.4};
  double y = equation(5.6);
  writeln(y);
}
