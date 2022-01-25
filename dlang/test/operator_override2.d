module operator_override2;

import std.stdio;
import std.string;
import std.conv;

struct DoubleEndedQueue {
private:
  int[] head;
  int[] tail;

  ref inout(int) elementAt(size_t index) inout {
    return (index < head.length ? head[$ - 1 - index] : tail[index - head.length]);
  }

public:
  string toString() const {
    string result;
    foreach_reverse (element; head) {
      result ~= format("%s ", to!string(element));
    }
    foreach (element; tail) {
      result ~= format("%s ", to!string(element));
    }
    return result;
  }

  version (none) {
    void toString(void delegate(const(char)[]) sink) const {
      import std.format;
      import std.range;

      formattedWrite(
        sink, "%(%s %)", chain(head.retro, tail));
    }
  }

  void insertAtHead(int value) {
    head ~= value;
  }

  int[] getHead() {
    return head;
  }

  int[] getTail() {
    return tail;
  }

  ref DoubleEndedQueue opOpAssign(string op)(int value) if (op == "~") {
    tail ~= value;
    return this;
  }

  inout(int) opIndex(size_t index) inout {
    return elementAt(index);
  }

  int opIndexUnary(string op)(size_t index) {
    mixin("return " ~ op ~ "elementAt(index);");
  }

  int opIndexAssign(int value, size_t index) {
    return elementAt(index) = value;
  }

  int opIndexOpAssign(string op)(int value, size_t index) {
    mixin("return elementAt(index) " ~ op ~ "= value;");
  }

  size_t opDollar() const {
    return head.length + tail.length;
  }
}

void main(string[] args) {
  auto deque = DoubleEndedQueue();

  foreach (i; 0 .. 10) {
    if (i % 2) {
      deque.insertAtHead(i);

    }
    else {
      deque ~= i;
    }
  }

  writeln("head: ", deque.getHead(), " tail: ", deque.getTail());

  writefln("Element at index 3: %s",
    deque[3]); // accessing an element
  ++deque[4]; // incrementing an element
  deque[5] = 55; // assigning to an element
  deque[6] += 66; // adding to an element

  (deque ~= 100) ~= 200;

  writeln(deque);
}
