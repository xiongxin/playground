
#include <iostream>
#include <string>
#include <type_traits>

template <typename T>
void
outR (T &arg)
{
  // static_assert (!std::is_const_v<T>, "is not allow const value");
}

const std::string
returnConstString ()
{
}

template <typename T>
void
passR (T &&arg)
{
  // arg declared as forwarding reference
}
std::string
returnString ()
{
}
int
main (int argc, char const *argv[])
{
  std::string s = "hi";
  passR (s); // OK: T deduced as std::string& (also the type of arg)
  passR (std::string (
      "hi")); // OK: T deduced as std::string, arg is std::string&&
  passR (
      returnString ());  // OK: T deduced as std::string, arg is std::string&&
  passR (std::move (s)); // OK: T deduced as std::string, arg is std::string&&
  int arr[4];
  passR (arr);
  return 0;
}
