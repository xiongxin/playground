module program_environment;

import std.stdio;
import std.getopt;
import std.random;
import std.conv;

void main(string[] args) {
  int count;
  int minimum;
  int maximum;

  getopt(args, "count|c", &count, "minimum|n", &minimum, "maximum|x", &maximum);

  foreach (i; 0 .. count) {
    write(uniform(minimum, maximum + 1), ' ');
  }

  writeln();
}
