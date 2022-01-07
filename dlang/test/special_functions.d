module special_functions;

import std.stdio;
import std.array;
import std.conv;
import std.random;

struct Duration {
  int minute;

  this(int hour, int minute) {
    this.minute = hour * 60 + minute;
  }

  this(int minute) {
    this(0, minute);
  }
}

struct Test {

  static Test opCall() {
    writeln("A test object is being contructed.");
    Test test;
    return test;
  }
}

class A {
}

struct Student {
  string filename;
  int[] grades;

  this(string filename) {
    this.filename = filename;
  }

  void save() {
    auto file = File(filename.idup, "w");
    file.writeln("The grades of the student:");
    file.writeln(grades);
  }
}

struct XmlElement {
  string name;
  string identation;

  this(string name, int level) {
    this.name = name;
    this.identation = identationString(level);

    writeln(identation, '<', name, '>');
  }

  ~this() {
    writeln(identation, "</", name, '>');
  }
}

string identationString(int level) {
  return replicate(" ", level * 2);
}

void main(string[] args) {
  writeln(Duration.init);
  A a;
  if (a is null) {
    writeln("is null");
  }
  writeln(Test());

  string fileName = "student_grades";

  auto student = Student(fileName);

  // ...

  /* Assume the fileName variable is modified later on
     * perhaps unintentionally (all of its characters are
     * being set to 'A' here): */
  // fileName[] = 'A';

  immutable calsses = XmlElement("classes", 0);

  foreach (classId; 0 .. 2) {
    immutable classTag = "class" ~ to!string(classId);
    immutable classElement = XmlElement(classTag, 1);

    foreach (i; 0 .. 3) {
      immutable gradeElement = XmlElement("grade", 2);
      immutable randomGrade = uniform(50, 101);

      writeln(identationString(3), randomGrade);
    }
  }
}
