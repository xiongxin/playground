module declaration;

template ArrayOf(T) {
  alias ArrayType = T[];
  alias ElementType = T;
}

template Transformer(From, To) // From and To are types
{
  To transform(From from) {
    import std.conv;

    return to!(To)(from);
  }

  class Modificator {
    From f;
    To t;
    this(From f) {
    }
  }
}

template nameOf(alias a) {
  enum string name = a.stringof; // enum: manifest constant
  // determined at compile-time.
  // See below.
}

template ComplicatedOne(T, string s, alias a, bool b, int i) { /* some code using T, s, a, b and i */ }

template Minimalist() {
} // Zero-parameter template declaration.

template OneOrMore(FirstType, Rest...) // Rest is a tuple.
{ /*...*/ }

template ZeroOrMore(Types...) // Types is a tuple.
{ /*...*/ }

template Multiple(T) { /*...*/ } // One arg version.
template Multiple(T, U) { /*...*/ } // Two args,
template Multiple(T, U, V) { /*...*/ } // and three.
