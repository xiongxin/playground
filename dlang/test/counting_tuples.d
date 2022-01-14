module counting_tuples;

import std.range : dropOne, only, save, zip;
import std.stdio : writefln, writeln;
import std.typecons : Tuple;
import std.utf : byCodeUnit; // avoids UTF-8 auto-decoding

class MyClass {
}

void main(string[] args) {
  int[Tuple!(immutable char, immutable char)] aa;

  // The string `arr` has a limited alphabet: {A, C, G, T}
  // Thus, for better performance, iteration can be done _without_ decoding
  auto arr = "AGATAGA".byCodeUnit;
  writeln(arr);
  // iterate over all pairs in the string and observe each pair
  // ('A', 'G'), ('G', 'A'), ('A', 'T'), ...
  foreach (window; arr.zip(arr.save.dropOne)) {
    writeln("window: ", window);
    aa[window]++;
  }

  // iterate over all key/value pairs of the Associative Array
  foreach (key, value; aa) {
    // the second parameter uses tuple-expansion
    writefln("key: %s [%s], value: %d", key, key.expand.only, value);
  }

  MyClass a = null;
  if (a is null) {
    writeln("null");
  }

  int[] aaa = [1, 2];
  int[] bbb = aaa;

  if (aaa is bbb) {
    writeln("aaaaaa");
  }
}
