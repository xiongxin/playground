#include <iostream>
#include <sigc++-3.0/sigc++/sigc++.h>
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

int main() {
  AlienDetector mydetector;
  mydetector.signal_detected.connect(sigc::ptr_fun(warn_people));

  mydetector.run();

  return 0;
}
