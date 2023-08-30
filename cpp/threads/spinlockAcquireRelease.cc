#include <atomic>
#include <chrono>
#include <iostream>
#include <thread>

class Spinlock {
    bool flag;

public:
    Spinlock() : flag{ ATOMIC_FLAG_INIT } {}

    void lock() {
        while ( flag )
            ;
    }

    void unlock() {
        flag.clear();
    }
};

Spinlock spin;
int      i = 0;

void workOnResource() {
    spin.lock();
    while ( i <= 100 ) {
        std::cout << i++ << '\n';
    }
    spin.unlock();
}

int main() {

    std::thread t( workOnResource );
    std::thread t2( workOnResource );

    t.join();
    t2.join();

    return 0;
}
