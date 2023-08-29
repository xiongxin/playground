#include <algorithm>

template <typename Object>
class Vector {
 public:
  explicit Vector(int initSize = 0)
      : theSize{initSize}, theCapacity{initSize + SPARE_CAPACITY} {
    objects = new Object[theCapacity];
  }

  Vector(const Vector &rhs)  // copy constructor
      : theSize{rhs.theSize}, theCapacity{rhs.theCapacity}, objects{nullptr} {
    objects = new Object[theCapacity];
    for (int k = 0; k < theSize; ++k)  // deep copy object
      objects[k] = rhs.objects[k];
  }

  Vector &operator=(const Vector &rhs) {  // copy assigment
    if (this != &rhs) {
      Vector copy = rhs;
      std::swap(copy, *this);
    }
    return *this;
  }

  Vector(Vector &&rhs) noexcept  // move constructor
      : theSize{rhs.theSize},
        theCapacity{rhs.theCapacity},
        objects{rhs.objects} {
    rhs.objects = nullptr;
    rhs.theSize = 0;
    rhs.theCapacity = 0;
  }

  Vector &operator=(Vector &&rhs) noexcept {  // move assigment
    if (this != &rhs) {
      Vector temp{std::move(rhs)};

      std::swap(theSize, temp.theSize);
      std::swap(theCapacity, temp.theCapacity);
      std::swap(objects, temp.objects);
    }

    return *this;
  }

  ~Vector() { delete[] objects; }

  void resize(int newSize) {
    if (newSize > theCapacity) reserve(newSize * 2);
    theSize = newSize;
  }

  void reserve(int newCapacity) {
    // reserve 在 1. newCapacity > theSize 时扩张底层数组
    //            2. newCapacity = theSize 时缩窄底层数组和 theSize 一样大
    if (newCapacity < theSize) return;
    Object *newArray = new Object[newCapacity];
    for (int k = 0; k < theSize; ++k) newArray[k] = std::move(objects[k]);
    theCapacity = newCapacity;
    std::swap(objects, newArray);
    delete[] newArray;
  }

  Object &operator[](int index) { return objects[index]; }
  const Object &operator[](int index) const { return objects[index]; }

  bool empty() const { return size() == 0; }
  int size() const { return theSize; }
  int capacity() const { return theCapacity; }

  void push_back(const Object &x) {
    if (theSize == theCapacity) reserve(2 * theCapacity + 1);
    objects[theSize++] = x;
  }
  void push_back(Object &&x) {
    if (theSize == theCapacity) reserve(2 * theCapacity + 1);
    objects[theSize++] = std::move(x);
  }

  void pop_back() { --theSize; }
  const Object &back() const { return objects[theSize - 1]; }

  typedef Object *iterator;
  typedef const Object *const_iterator;

  iterator begin() { return &objects[0]; }
  const_iterator begin() const { return &objects[0]; }

  iterator end() { return &objects[size()]; }
  const_iterator end() const { return &objects[size()]; }

  static const int SPARE_CAPACITY = 16;

 private:
  int theSize;

  int theCapacity;
  Object *objects;
};

int main(int argc, char const *argv[]) {
  Vector<int> v1(12);
  Vector<int> v2(33);
  v1 = std::move(v2);
  return 0;
}
