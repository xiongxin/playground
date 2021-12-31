#include <iostream>
#include <list>
#include <string>
#include <vector>

template <typename T>
class Less_than {
    const T val;

   public:
    Less_than(const T& v) : val(v) {}
    bool operator()(const T& x) const { return x < val; }
};

template <typename C, typename P>
int count(const C& c, P pred) {
    int cnt = 0;
    for (const auto& x : c)
        if (pred(x)) ++cnt;

    return cnt;
}

void f(const std::vector<int>& vec, const std::list<std::string>& lst, int x,
       const std::string& s) {
    std::cout << ":" << count(vec, Less_than<int>{x});
    std::cout << ":" << count(lst, Less_than<std::string>{s});
}

template <typename T>
void g(T x) {
    std::cout << x << " ";
}

void f() {}

template <typename T, typename... Tail>
void f(T head, Tail... tail) {
    g(head);
    f(tail...);
}
int main() {
    std::cout << "first:";
    f(1, 2.2, "Hello");

    std::string s{"aaaa"};
}