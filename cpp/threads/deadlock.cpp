#include <chrono>
#include <iostream>
#include <mutex>
#include <thread>

struct CriticalData {
    std::mutex mut;
};

void deadLock( CriticalData& a, CriticalData& b ) {

    std::unique_lock< std::mutex > guard1( a.mut, std::defer_lock );
    std::cout << "Thread: " << std::this_thread::get_id() << " first mutex" << std::endl;

    std::this_thread::sleep_for( std::chrono::milliseconds( 1 ) );

    std::unique_lock< std::mutex > guard2( b.mut, std::defer_lock );
    std::cout << "    Thread: " << std::this_thread::get_id() << " second mutex" << std::endl;
    std::cout << "        Thread: " << std::this_thread::get_id() << " get both mutex" << std::endl;
    std::lock( guard1, guard2 );

    std::cout << "GET TWO LOCK " << std::this_thread::get_id() << std::endl;
    std::this_thread::sleep_for( std::chrono::seconds( 5 ) );
}

std::mutex mtx1;

void func() {
    std::unique_lock< std::mutex > lock1( mtx1 );

    std::cout << "GET ONE LOCK " << std::this_thread::get_id() << std::endl;
    {
        std::unique_lock< std::mutex > lock2( mtx1 );  // 错误,会发生死锁

        std::cout << "GET TWO LOCK " << std::this_thread::get_id() << std::endl;
    }
}

int main() {

    // CriticalData c1;
    // CriticalData c2;

    // std::thread t1( [ & ] { deadLock( c1, c2 ); } );
    // std::thread t2( [ & ] { deadLock( c2, c1 ); } );

    // t1.join();
    // t2.join();

    // std::cout << std::endl;

    func();

    return 0;
}
