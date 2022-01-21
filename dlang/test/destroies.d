module destroies;

import std.stdio;

void main(string[] args) {
  int j = 1;
  writefln("%b", 30);

  const courses = new XmlElement("courses", 0);
  import std.conv;
  import std.random;

  foreach (courseId; 0 .. 2) {
    const courseTag = "course" ~ to!string(courseId);
    const courseElement = new XmlElement(courseTag, 1);

    foreach (i; 0 .. 3) {
      const gradeElement = new XmlElement("grade", 2);
      const randomGrade = uniform(50, 101);

      writeln(indentationString(3), randomGrade);
      destroy(gradeElement);
    }

    destroy(courseElement);

  }

  destroy(courses);
}

string indentationString(int level) {
  import std.array;

  return replicate(" ", level * 2);
}

class XmlElement {
  string name;
  string indentation;

  this(string name, int level) {
    this.name = name;
    this.indentation = indentationString(level);
    writeln(indentation, '<', name, '>');
  }

  ~this() {
    writeln(indentation, "</", name, '>');
  }
}

class LifetimeObserved {
  int[] array;

  static size_t counter;

  this() {
    array.length = 30_000;

    ++counter;
  }

  ~this() {
    --counter;
  }
}
