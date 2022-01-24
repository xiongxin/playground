module template4;

import std.string;

string structDefinition(string name, Members...)() {
  static assert((Members.length % 2) == 0, "Members must be specified as pairs.");

  string result = "struct " ~ name ~ "\n{\n";

  foreach (i, arg; Members) {
    static if (i % 2) {
      static assert(is(typeof(arg) == string), "Member name " ~ arg.stringof ~ " is not a string");
    }
    else {
      static assert(is(arg), arg.stringof ~ " is not a type.");

      result ~= format("    %s %s;\n", Members[i].stringof, Members[i + 1]);
    }
  }

  result ~= "}";

  return result;
}

import std.stdio;

int sum(int last)() {
  return (last == 0
      ? last : last + sum!(last - 1)());
}

void main(string[] args) {
  writeln(structDefinition!("Student",
      string, "name",
      int, "id",
      int[], "grades")());

  writeln(sum!4());
}
