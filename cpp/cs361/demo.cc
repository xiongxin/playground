#include <iostream>
#include <string>
using namespace std;

class testClass {
 public:
  operator std::string() { return "hello"; };
};

ostream& operator<<(ostream& out, const string& s) {
  cout << "ssdfs"
       << "\n";
}

int main() {
  std::string s = "goodday";

  testClass t;

  s = t;

  cout << t << endl;

  return 0;
}
