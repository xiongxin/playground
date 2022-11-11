#include <iostream>
#include <string>

using namespace std;

class Entry2 { // two alternative representations represented as a union
private:
  enum class Tag { number, text };
  Tag type; // discriminant
  union {   // representation
    int i;
    string s; // string has default constructor, copy operations, and destructor
  };

public:
  struct Bad_entry {}; // used for exceptions
  string name;
  ~Entry2();
  Entry2 &operator=(const Entry2 &);
  Entry2(const Entry2 &);
  // ...
  // necessar y because of the string variant
  int number() const;
  string text() const;
  void set_number(int n);
  void set_text(const string &);
  // ...
};

int Entry2::number() const {
  if (type != Tag::number)
    throw Bad_entry{};
  return i;
}

string Entry2::text() const {
  if (type != Tag::text)
    throw Bad_entry{};
  return s;
}

void Entry2::set_number(int n) {
  if (type == Tag::text) {
    s.~string();
    type = Tag::number;
  }
  i = n;
}

void Entry2::set_text(const string &ss) {
  if (type == Tag::text) {
    s = ss;
  } else {
    new (&s) string{ss};
    type = Tag::text;
  }
}

int main(int argc, char const *argv[]) {
  cout << sizeof(string *) << "\n";
  cout << sizeof(string) << "\n";
  cout << sizeof(Entry2) << "\n";
  return 0;
}
