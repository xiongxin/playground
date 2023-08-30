#include <atomic>
#include <iostream>
#include <thread>

std::atomic< int > x( 0 );

void increment() {
    int expected = 0;
    int desired  = 1;
    while ( !x.compare_exchange_weak( expected, desired ) ) {
        expected = 0;
    }
}

int main() {
    std::thread t1( increment );
    std::thread t2( increment );
    t1.join();
    t2.join();
    std::cout << x << std::endl;
    return 0;
}
