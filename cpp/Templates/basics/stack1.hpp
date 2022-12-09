#include <cassert>
#include <vector>

template <typename T> class Stack {
private:
  std::vector<T> elems;

public:
  void push(T const &elem);
  void pop();
  T const &top() const;
  bool empty() const { return elems.empty(); }
};

template <typename T> void Stack<T>::push(T const &elem) {
  elems.push_back(elem); // append copy of passed elem
}

template <typename T> void Stack<T>::pop() {
  assert(!elems.empty());
  elems.pop_back();
}

// remove last element
template <typename T> T const &Stack<T>::top() const {
  assert(!elems.empty());
  return elems.back(); // return copy of last element
}
