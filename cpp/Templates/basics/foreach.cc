#include <iostream>
#include <vector>

template <typename Iter, typename Callable>
void foreach (Iter current, Iter end, Callable op) {
  while (current != end) {  // as long as not reached the end
    op(*current);           // call passed operator for current element
    ++current;              // and move iterator to next element
  }
}

void func(int i) { std::cout << "func() called for: " << i << "\n"; }

class FuncObj {
 public:
  void operator()(int i) const {
    std::cout << "FuncObj::op() called for: " << i << '\n';
  }
};

int main(int argc, char const *argv[]) {
  std::vector<int> primes = {2, 3, 5, 7, 11, 13, 17, 19};
  foreach (primes.begin(), primes.end(), func)  // range
    ;  // function as callable (decays to pointer)

  foreach (primes.begin(), primes.end(), &func)  // range
    ;                                            // function pointer as callable

  foreach (primes.begin(), primes.end(), FuncObj())  // range
    ;  // function object as callable

  foreach (primes.begin(), primes.end(),  // range
           [](int i) {
             // lambda as callable
             std::cout << "lambda called for: " << i << '\n';
           })
    ;

  return 0;
}
