#include "src/square.h" // square.h is also included once here
#include <iostream>
#include <plog/Initializers/RollingFileInitializer.h>
#include <plog/Log.h>

int getUserInput() {
  PLOGD << "getUserInput() called";
  std::cout << "Enter a number:";
  int x{};
  std::cin >> x;
  return x;
}

int main() {
  plog::init(plog::debug, "Logfile.txt"); // Step 2: initialize the logger
  PLOGD << "main() called"; // Step 3: Output to the log as if you were writing
                            // to the console
  int x{getUserInput()};
  std::cout << "You entered: " << x << std::endl;
  return 0;
}