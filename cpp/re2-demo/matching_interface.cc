#include <cassert>
#include <iostream>
#include <re2/re2.h>
#include <string>

using namespace re2;
using namespace std;
int main() {

  string hello;
  assert(RE2::FullMatch("hello aab", "(h.*)", &hello));
  cout << hello << '\n';
  assert(RE2::PartialMatch("hello", "e"));

  int i;
  string s;

  assert(RE2::FullMatch("ruby:1234", "(\\w+):(\\d+)", &s, &i));
  assert(i == 1234);
  assert(s == "ruby");
  RE2 re("(\\w++):(\\d+)");
  // assert(re.ok()); // compiled; if not, see re.error();
  RE2 re2("(ab", RE2::Quiet); // don't write to stderr for parser failure
  cout << re.error();
  return 0;
}
