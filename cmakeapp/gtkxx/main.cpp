#include <glibmm/ustring.h>
#include <iostream>
#include <sigc++/sigc++.h>
#include <string>

class AlienDetector {
public:
  AlienDetector() = default;

  void run() {
    sleep(3); // wait for aliens
    signal_detected.emit("park");
  }

  sigc::signal<void(std::string)> signal_detected;
};

void warn_people(std::string where) {
  std::cout << "There are aliens in the " << where << "!" << std::endl;
}

class A {
public:
  A(int i) {
    std::cout << "A"
              << "\n";
  }
};

void testf(A a, bool b) {
  std::cout << "testf"
            << "\n";
}

int main() {
  AlienDetector mydetector;
  mydetector.signal_detected.connect(sigc::ptr_fun(warn_people));

  mydetector.run();
  testf(1, 0);
  return 0;
}
