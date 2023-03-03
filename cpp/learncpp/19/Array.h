#ifndef ARRAY_H
#define ARRAY_H

#include <cassert>

template <typename T>
class Array {
 private:
  int m_length{};
  T* m_data{};

 public:
  Array(int length) {
    assert(length > 0);
    m_data = T[length]{};
    m_length = length;
  }

  Array(const Array&) = delete;
  Array& operator=(const Array&) = delete;

  ~Array() { delete[] m_data; }

  void erase() {
    delete[] m_data;

    m_data = nullptr;
    m_length = 0;
  }

  T& operator[](int index) {
    assert(index >= 0 && index < m_length);
    return m_data[index];
  }

  int getLength()
      const;  // note that this is only a declaration, not a definition
};

#include "Array.inl"

#endif
