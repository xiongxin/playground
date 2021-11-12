#include <iostream>
#include <string>

template <typename T>
class Less_than {
    const T val;  // value to compare against
   public:
    Less_than(const T& v) : val(v) {}
    bool operator()(const T& x) const { return x < val; }  // call operator
};

int main(int argc, char const* argv[]) {
    Less_than<int> lti{42};
    Less_than<std::string> lts{"Backus"};
    Less_than<std::string> lts1{"aBackus"};

    std::cout << lti(41) << std::endl;
    std::cout << lts("abc") << std::endl;

    return 0;
}
