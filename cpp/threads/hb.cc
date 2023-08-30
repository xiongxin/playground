
#include <atomic>
#include <cassert>
#include <iostream>
#include <mutex>
#include <thread>
#include <utility>

std::mutex mtx;

std::atomic_bool flag{ false };

void thread_1() {
    bool expected = flag.load( std::memory_order_relaxed );
    if ( expected ) {
        // do_something();
    }
    flag.store( true, std::memory_order_acquire );
    bool actual = flag.load( std::memory_order_relaxed );
    assert( actual );  // 此处必定为true
}

void thread_2() {
    flag.store( true, std::memory_order_release );
}
int main() {

    std::thread t2( thread_2 );
    std::thread t( thread_1 );

    // t = std::move(t2);
    t.join();
    t2.join();

    return 0;
}
