module internaldeclarations1;

import declaration;
import std.stdio;

ArrayOf!(int).ArrayType array;
ArrayOf!(int).ElementType element;

void main(string[] args) {
  auto s = Transformer!(double, string).transform(3.14159);
  writeln(s);
}
