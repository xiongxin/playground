#include <fstream>
#include <iostream>
#include <iterator>
#include <set>
#include <string>

int main() {
    std::string from =
        "/home/xiongxin/Data/Code/playground/cpp/TCPL/complex1.cpp";
    std::string to =
        "/home/xiongxin/Data/Code/playground/cpp/TCPL/complex1.cpp1";

    std::ifstream is{from};
    std::ofstream os{to};

    std::set<std::string> b{std::istream_iterator<std::string>{is},
                            std::istream_iterator<std::string>{}};
    for (auto& s : b) {
        std::cout << s << std::endl;
    }
    std::copy(b.begin(), b.end(), std::ostream_iterator<std::string>{os, "\n"});
};