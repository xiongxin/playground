import std.stdio;
import std.traits;

enum MyEnum
{
  init,
}

enum Suit
{
  spades,
  hearts,
  diamonds,
  clubs
}

void main(string[] args)
{
  writeln(MyEnum.init);
  writeln(int.stringof);

  for (auto suit = Suit.min; suit <= Suit.max; ++suit)
  {
    writefln("%s: %d", suit, suit);
  }

  foreach (suit; EnumMembers!Suit)
  {
    writefln("%s: %d", suit, suit);
  }
}
