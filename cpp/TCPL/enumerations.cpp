#include <iostream>

enum class Color { red, blue, green };
enum class Traffic_light { green, yellow, red };
Traffic_light& operator++(Traffic_light& t) {
    switch (t) {
        case Traffic_light::green:
            return t = Traffic_light::yellow;
        case Traffic_light::yellow:
            return t = Traffic_light::red;
        case Traffic_light::red:
            return t = Traffic_light::green;
    }
}

int main(int argc, char const* argv[]) {
    Color col = Color::red;
    Traffic_light light = Traffic_light::red;

    std::cout << (Color::red < Color::green) << std::endl;
    Traffic_light next = ++light;
    std::cout << (next < light) << std::endl;

    static_assert(4 <= sizeof(int), "integers are too small");
    return 0;
}
