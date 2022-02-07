module ranges;
import std.stdio;
import std.algorithm;
import std.range;
import std.string;

void print(T)(T range) {
  for (; !range.empty; range.popFront()) {
    write(' ', range.front);
  }

  writeln();
}

struct Student {
  string name;
  int number;

  string toString() const @safe pure {
    return format("%s(%s)", name, number);
  }
}

struct School {
  Student[] students;

  bool empty() const {
    return students.length == 0;
  }

  ref Student front() {
    return students[0];
  }

  void popFront() {
    students = students[1 .. $];
  }
}

void main(string[] args) {
  int[] values = [1, 20, 7, 11];
  // int[] a = values.map!(value => value + 100);
  print(values);
  values.each!(v => writeln(v));

  auto school = School([
    Student("Ebru", 1),
    Student("Derya", 2),
    Student("Damla", 3)
  ]);

  school.each!(s => writeln(s));
  //print!School(school);

  auto c = "abcçdeé𝔸"c;
  c.stride(1).each!(v => writeln(v));
}
