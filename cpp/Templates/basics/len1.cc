#include <iostream>
#include <memory>

template <typename T, unsigned N>
std::size_t
len (T (&)[N])
{
  return N;
}

// number of elements for a type having size_type:
template <typename T>
typename T::size_type
len (T const &t)
{
  return t.size ();
}

int
main (int argc, char const *argv[])
{
  std::allocator<int> x;
  std::cout << len (x);
  // ERROR: len() function found, but can’t size()
  return 0;
}
