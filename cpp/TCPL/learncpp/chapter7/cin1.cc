#include <iostream>
#include <limits> // for std::numeric_limits

// To ignore everything up to and including the next ‘\n’ character
void ignoreLine() {
  std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
}

double getDouble() {
  while (true) // Loop until user enters a valid input
  {
    std::cout << "Enter a double value: ";
    double x{};
    std::cin >> x;

    if (std::cin.fail()) // has a previous extraction failed?
    {
      // yep, so let's handle the failure
      std::cin.clear(); // put us back in 'normal' operation mode
      ignoreLine();     // and remove the bad input
    } else              // else our extraction succeeded
    {
      ignoreLine();
      return x; // so return the value we extracted
    }
  }
}

char getOperator() {
  while (true) // Loop until user enters a valid input
  {
    std::cout << "Enter one of the following: +, -, *, or /: ";
    char operation{};
    std::cin >> operation;

    // Check whether the user entered meaningful input
    switch (operation) {
    case '+':
    case '-':
    case '*':
    case '/':
      return operation; // return it to the caller
    default:            // otherwise tell the user what went wrong
      std::cerr << "Oops, that input is invalid.  Please try again.\n";
    }
  } // and try again
}

void printResult(double x, char operation, double y) {
  switch (operation) {
  case '+':
    std::cout << x << " + " << y << " is " << x + y << '\n';
    break;
  case '-':
    std::cout << x << " - " << y << " is " << x - y << '\n';
    break;
  case '*':
    std::cout << x << " * " << y << " is " << x * y << '\n';
    break;
  case '/':
    std::cout << x << " / " << y << " is " << x / y << '\n';
    break;
  }
}

int main() {
  double x{getDouble()};
  char operation{getOperator()};
  double y{getDouble()};

  printResult(x, operation, y);

  return 0;
}