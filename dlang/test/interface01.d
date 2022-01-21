class MusicalInstrument {
}

class StringInstrument : MusicalInstrument {
}

class Violin : StringInstrument {
}

class Guitar : StringInstrument {
}

import std.stdio : writeln, writefln;

int foo(string when) {
  writefln("Called during '%s'.", when);
  return 0;
}

class Clock {
  int hour;
  int minute;
  int second;

  override int opCmp(Object o) const {
    /* Taking advantage of the automatically-maintained
         * order of the types. */
    if (typeid(this) != typeid(o)) {
      return typeid(this).opCmp(typeid(o));
    }

    auto rhs = cast(const Clock) o;
    /* No need to check whether rhs is null, because it is
         * known at this line that it has the same type as o. */

    if (hour != rhs.hour) {
      return hour - rhs.hour;

    }
    else if (minute != rhs.minute) {
      return minute - rhs.minute;

    }
    else {
      return second - rhs.second;
    }
  }

  // ...
}

import std.exception;

void main() {
  TypeInfo v = typeid(Violin);
  TypeInfo g = typeid(Guitar);
  writeln(v, g, v == g);
  assert(v != g); // ← the two types are not the same

  Violin v1 = new Violin;
  Violin v2 = new Violin;
  if (v1 is v2) {
    writeln("v1 and v2 are equal");
  }
  writeln(v1.classinfo.name);

  try {
    enforce(null, "op is null");

  }
  catch (Exception e) {
    writeln("is exception!!!");
  }
}
