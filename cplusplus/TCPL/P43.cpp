#include <iostream>
#include <string>

struct Entry {
    std::string name;
    int number;
};

std::ostream& operator<<(std::ostream& os, const Entry& e) {
    return os << "{\"" << e.name << "\"," << e.number << "}";
}

std::istream& operator<<(std::istream& is, Entry& e)
// read {"name", number} pair
{
    char c, c2;
    // is>>c skips whitespace by default, but is.get(c) does not,
    // so that this Entry-input operator ignores(skips) whitespace
    // outside the same string, but not within it.
    if (is >> c && c == '{' && is >> c2 && c2 == '"') {  // start with a "{"
        std::string name;
        while (is.get(c) && c != '"') {
            name += c;
        }

        if (is >> c && c == ',') {
            int number = 0;
            if (is >> number >> c && c == '}') {
                e = {name, number};
                return is;
            }
        }
    }
    // is.setf(std::ios_base::failbit);
    return is;
}

int main() {
    Entry entry{"naa", 122};
    std::cout << entry << std::endl;
    return 0;
}