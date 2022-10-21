#include <iostream>
#include <memory>
#include <utility>

template <class T, class A = std::allocator<T>>
struct vector_base { // memor y structure for vector
  A alloc;           // allocator
  T *elem;           // star t of allocation
  T *space; // end of element sequence, star t of space allocated for possible
            // expansion
  T *last;  // end of allocated space

  vector_base(const A &a, typename A::size_type n)
      : alloc{a}, elem{alloc.allocate(n)}, space{elem + n}, last{elem + n} {}
  ~vector_base() {
    std::cout << "~vector_base\n";
    alloc.deallocate(elem, last - elem);
  }

  vector_base(const vector_base &) = delete; // no copy operations
  vector_base &operator=(const vector_base &) = delete;

  vector_base(vector_base &&); // move operations
  vector_base &operator=(vector_base &&);
};

template <class T, class A>
void swap(vector_base<T, A> &a, vector_base<T, A> &b) {
  a.alloc = b.alloc; // copy alocator
  std::swap(a.elem, b.elem);
  std::swap(a.space, b.space);
  std::swap(a.last, b.last);
}

template <class T, class A>
vector_base<T, A>::vector_base(vector_base &&a)
    : alloc{a.alloc}, elem{a.elem}, space{a.space}, last{a.space} {
  a.elem = a.space = a.last = nullptr; // no longer owns any memory
}

template <class T, class A>
vector_base<T, A> &vector_base<T, A>::operator=(vector_base &&a) {
  swap(*this, a);
  return *this;
}

template <class T, class A = std::allocator<T>> class vector {
  vector_base<T, A> vb; // the data is here
  void destroy_elements();

public:
  using size_type = unsigned int;

  explicit vector(size_type n, const T &val = T(), const A & = A());

  vector(const vector &a);            // copy constructor
  vector &operator=(const vector &a); // copy assignment

  vector(vector &&a);            // move constructor
  vector &operator=(vector &&a); // move assignment

  ~vector() {
    std::cout << "~vecotr\n";
    destroy_elements();
  }

  size_type size() const { return vb.space - vb.elem; }
  size_type capacity() const { return vb.last - vb.elem; }

  void reserve(size_type); // increase capacity

  void resize(size_type, T = {}); // change the number of elements
  void clear() { resize(0); }     // make the vector empty
  void push_back(const T &);      // add an element at the end

  // ...
};

template <class T, class A> void vector<T, A>::destroy_elements() {

  for (T *p = vb.elem; p != vb.space; ++p)
    p->~T(); // destroy element
  vb.space = vb.elem;
}

template <class T, class A>
vector<T, A>::vector(size_type n, const T &val, const A &a)
    : vb{a, n} // allocate space for n elements
{
  // This style of constructor relies on the fundamental language rule that when
  // an exception is thrown
  // from a constructor, subobjects (including bases) that have already been
  // completely constructed will be properly destroyed
  std::uninitialized_fill(vb.elem, vb.elem + n, val);
}

template <class T, class A>
vector<T, A>::vector(const vector<T, A> &a)
    : vb{a.alloc, a.size()} // allocate space for n elements
{
  // This style of constructor relies on the fundamental language rule that when
  // an exception is thrown
  // from a constructor, subobjects (including bases) that have already been
  // completely constructed will be properly destroyed
  std::uninitialized_copy(a.begin(), a.end(), vb.elem);
}

template <class T, class A>
vector<T, A>::vector(vector &&a) // move constructor
    : vb{std::move(a.vb)}        // transfer ownership
{}

template <class T, class A>
vector<T, A> &vector<T, A>::operator=(vector &&a) // move assignment
{
  swap(vb, a.vb);
  return *this;
}

struct P {};

// Driver Code
int main() {
  std::allocator<P> allocator{};
  // vector_base<P> a{allocator, 10};
  // vector_base<P> b{allocator, 10};
  // a = std::move(b);
  // try {
  //   vector<P> v{10, P{}, allocator};
  // } catch (...) {
  // }

  vector<P> v1{10, P{}, allocator};
  vector<P> v2{20, P{}, allocator};
  v1 = std::move(v2);
  return 0;
}
