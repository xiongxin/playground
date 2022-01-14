module aa;

import std.stdio;

// immutable long[string] aa;

// shared static this() {
//   import std.exception : assumeUnique;
//   import std.conv : to;

//   long[string] temp; // mutable buffer
//   foreach (i; 0 .. 10) {
//     temp[to!string(i)] = i;
//   }
//   temp.rehash; // for faster lookups

//   aa = assumeUnique(temp);
// }

void main(string[] args) {
    int[string] dayNumbers;
    // associates value 0 with key "Monday"
    dayNumbers["Monday"] = 0;

    // associates value 1 with key "Tuesday"
    dayNumbers["Tuesday"] = 1;


    writeln(dayNumbers);

    int[int] aa;
    ++aa[1];
    writeln(aa);
}
