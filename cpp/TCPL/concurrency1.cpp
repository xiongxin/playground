#include <iostream>
#include <memory>
#include <mutex>
#include <thread>

std::mutex m;
int sh;

void f() {
    std::unique_lock<std::mutex> lck{m};
    std::cout << "Hello ";
}

struct F {
    void operator()() { std::cout << "Parallel World!\n"; }
};

int main(int argc, char const *argv[]) {
    std::thread t1{f};
    std::thread t2{F()};

    t1.join();
    t2.join();

    return 0;
}
