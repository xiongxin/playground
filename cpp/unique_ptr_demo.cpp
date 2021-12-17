#include <cassert>
#include <cstdio>
#include <fstream>
#include <iostream>
#include <memory>
#include <stdexcept>

// helper class for runtime polymorphism demo below
struct B {
    virtual ~B() = default;
    virtual void bar() {
        std::cout << "B::bar()\n";
    }
};

struct D : B {
    D() {
        std::cout << "Init D: D::D()\n";
    }

    ~D() {
        std::cout << "D::~D()\n";
    }

    void bar() override {
        std::cout << "D::bar()\n";
    }
};

// a function consuming a unique_ptr cant take it by value
std::unique_ptr<D> pass_through(std::unique_ptr<D> p) {
    p->bar();

    return p;
}

void close_file(std::FILE *f) {
    std::fclose(f);
}

// unique_ptr-based linked list demo
struct List {
    struct Node {
        int data;
        std::unique_ptr<Node> next;
    };

    std::unique_ptr<Node> head;

    ~List() {
        while (head) {
            auto tmp = std::move(head);
            head = std::move(tmp->next);
        }
    }

    void push(int data) {
        head = std::unique_ptr<Node>(new Node{data, std::move(head)});
    }
};

int main() {

    std::cout << "1) Unique ownersip semantics demo\n";
    {
        // Create a (uniquely owned) resource
        std::unique_ptr<D> p = std::make_unique<D>();

        // Transfer ownship to `pass_through`
        // which in turn transfers ownership back through
        std::unique_ptr<D> q = pass_through(std::move(p));
        // `p` is now in a moved-from 'empty' state, equal to `nullptr`
        assert(!p);
    }
    std::cout << "end 1);\n";

    std::cout << "2) Runtime polymorphism demo\n";
    {
        // Create a derived resource and point to it via base type
        std::unique_ptr<B> p = std::make_unique<D>();

        // Dynamic dispathc works as expected
        p->bar();
    }
    std::cout << "end 2);\n";

    std::cout << "3) Custom deleter demo\n";
    std::ofstream("demo.txt") << "x"; // prepare the file to read

    {
        using unique_file_t = std::unique_ptr<std::FILE, decltype(&close_file)>;
        unique_file_t fp(std::fopen("demo.txt", "r"), &close_file);
        if (fp)
            std::cout << char(std::fgetc(fp.get())) << "\n";
    }
    std::cout << "end 3);\n";

    std::cout << "4) Custom lambda-expression deleter and exception safety demo\n";
    try {
        std::unique_ptr<D, void (*)(D *)> p(new D, [](D *ptr) {
            std::cout << "destroying from a custom deleter...\n";
            delete ptr;
        });

        throw std::runtime_error(""); // `p` would leak here if it were instead a plain pointer
    } catch (const std::exception &) {
        std::cout << "Caught exception\n";
    }
    std::cout << "end 4);\n";

    std::cout << "5) Array from of unique_ptr demo\n";
    {
        std::unique_ptr<D[]> p(new D[3]);
    }
    std::cout << "end 5);\n";

    std::cout << "6) Linked list demo\n";
    {
        List wall;
        for (int beer = 0; beer != 1'000'000; ++beer)
            wall.push(beer);

        std::cout << "1'000'000 bottles of on the wall...\n";
    }
    std::cout << "end 6);\n";

    return 0;
}