// A simple program that computes the square root of a number
#include <cmath>
#include <iostream>
#include <string>

// TODO 11: Include TutorialConfig.h
#include "TutorialConfig.h"

int main(int argc, char *argv[]) {
  std::cout << argv[0] << " MyVariable " << MyVariable << std::endl;

  if (argc < 2) {
    // report version
    std::cout << argv[0] << " Version " << Tutorial_VERSION_MAJOR << "."
              << Tutorial_VERSION_MINOR << std::endl;

    std::cout << "Usage: " << argv[0] << " number" << std::endl;
    return 1;
  }

  // convert input to double
  // TODO 4: Replace atof(argv[1]) with std::stod(argv[1])
  const double inputValue = std::stod(argv[1]);

  // calculate square root
  const double outputValue = sqrt(inputValue);
  std::cout << "The square root of " << inputValue << " is " << outputValue
            << std::endl;
  return 0;
}
