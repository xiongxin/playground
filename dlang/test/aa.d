module aa;

import std.stdio;

void main(string[] args) {
  int[string] dayNumbers;
  // associates value 0 with key "Monday"
  dayNumbers["Monday"] = 0;

  // associates value 1 with key "Tuesday"
  dayNumbers["Tuesday"] = 1;

  writeln(dayNumbers);
}
