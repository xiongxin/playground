#include <iostream>

class P {
   public:
    int* id;
    P() : id(nullptr) {}
    P(const P& a) {
        std::cout << "=====555========" << std::endl;
        id = a.id;
    }
    P& operator=(P& a) {
        std::cout << "=======444======" << std::endl;
        return *this;
    }
    P& operator=(P&& a) {
        std::cout << "=======333======" << std::endl;
        id = a.id;
        a.id = nullptr;

        return *this;
    }

    P(P&& a) : id(a.id) {
        std::cout << "======222=======" << std::endl;
        a.id = nullptr;
    }
    ~P() {
        std::cout << "======111=======" << std::endl;
        delete[] id;
    }
};

P getP() {
    P p;
    p.id = new int(1);
    std::cout << p.id << std::endl;
    return p;
}

int main() {
    P p;
    p = getP();     // p is moved from getP();
    P p1 = getP();  // p1 is initialized from getP();
    std::cout << p.id << std::endl;
    return 0;
}