#include <iostream>
#include <string>
#include <utility>

class Array {
  int size;
  int* data;

 public:
  Array(int _size) : size{_size}, data{new int[_size]} {}
  Array(Array const& copy) : size(copy.size), data(new int[size]) {
    std::copy(copy.data, copy.data + size, data);
  }
  Array& operator=(Array copy)  // Pass by value to implicitly do the copy.
  {
    swap(*this, copy);  // Copy has been. So just update the
    return *this;       // state of this object in an exception safe way.
  }
  Array(Array&& temp)
      : data{std::exchange(temp.data, nullptr)},
        size{std::exchange(temp.size, 0)} {}
  Array& operator=(Array&& temp) noexcept {
    Array to_destory{
        std::move(temp)};  // https://cplusplus.com/forum/beginner/258593/
    swap(*this, to_destory);
    return *this;
  }
  friend void swap(
      Array& lhs,
      Array& rhs) noexcept {  // Swap content with no change of exception.
    using std::swap;
    swap(lhs.data, rhs.data);
    swap(lhs.size, rhs.size);
  }
  ~Array() { delete[] data; }

  int get_size() { return size; }
};

int main(int argc, char const* argv[]) {
  Array a1{10};
  Array a2{1000};
  using std::swap;
  swap(a1, a2);
  std::cout << a1.get_size() << " " << a2.get_size() << '\n';

  Array a3{std::move(a2)};
  std::cout << a3.get_size() << " " << a2.get_size() << '\n';
  return 0;
}
