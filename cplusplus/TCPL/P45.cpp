#include <iostream>
#include <iterator>
#include <ostream>
#include <string>

int main() {
    std::ostream_iterator<std::string> oo{std::cout};
    *oo = "Hello,";
    ++oo;
    *oo = "world!\n";
    return 0;
}