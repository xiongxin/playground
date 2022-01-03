module exceptions;

import std.stdio;
import std.random;
import std.string;

int[] randomDiceValues(int count) {
  if (count < 0) {
    throw new Exception(format("Invalid dice count: %s", count));
  }

  int[] values;

  foreach (i; 0 .. count) {
    values ~= uniform(1, 7);
  }

  return values;
}

void main(string[] args) {
  writeln(randomDiceValues(-5));
}

void useTheFile(string fileName) {
  auto file = File(fileName, "r");
}
