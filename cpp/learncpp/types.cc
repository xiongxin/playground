#include <iostream>
#include <string>
#include <type_traits>
#include <typeinfo>

const std::string* const getConstPtr() {
  static std::string a{"abc"};
  return &a;
}  // some function that returns a const pointer to a const value

int main() {
  auto ptr1{getConstPtr()};   // const std::string*
  auto* ptr2{getConstPtr()};  // const std::string*

  std::cout << typeid(ptr1).name() << std::endl;
  std::cout << typeid(ptr2).name() << std::endl;

  auto const ptr3{getConstPtr()};  // const std::string* const
  const auto ptr4{getConstPtr()};  // const std::string* const
  std::cout << typeid(ptr3).name() << std::endl;
  std::cout << typeid(ptr4).name() << std::endl;

  std::cout << std::is_same_v<decltype(ptr1), decltype(ptr3)> << std::endl;

  auto* const ptr5{getConstPtr()};  // const std::string* const
  const auto* ptr6{getConstPtr()};  // const std::string*
  std::cout << typeid(ptr5).name() << std::endl;
  std::cout << typeid(ptr6).name() << std::endl;

  int a = 1;
  const int* const ptr7 = &a;
  std::cout << typeid(ptr7).name() << std::endl;
  // const auto const ptr7{ getConstPtr() };  // error: const qualifer can not
  // be applied twice const auto* const ptr8{ getConstPtr() }; // const
  // std::string* const

  return 0;
}
