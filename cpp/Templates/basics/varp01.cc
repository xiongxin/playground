#include <iostream>
#include <string>

#include <iostream>
template <typename T>
void print(T arg)
{
    std::cout << arg << '\n'; // print passed argument
}

template <typename T, typename... Types>
void print(T firstArg, Types... args)
{
    print(firstArg); // call print() for the first argument
    if (sizeof...(args) > 0)
    {
        print(args...);
    }
}

int main(void)
{
    std::string s("world");
    print(7.5, "hello", s);
}