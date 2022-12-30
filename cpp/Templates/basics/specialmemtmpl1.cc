#include <iostream>
#include <string>
#include <type_traits>
#include <utility>

template <typename T>
using EnableIfString = std::enable_if_t<std::is_convertible_v<T, std::string>>;

class Person {
private:
public:
  std::string name;

  template <typename STR, typename = EnableIfString<STR>>
  explicit Person(STR &&n) : name(std::forward<STR>(n)) {
    std::cout << "TMPL-CONSTR for ’" << name << "’\n";
  }

  // constructor for passed initial name:
  // explicit Person(std::string const &n) : name(n) {
  //   std::cout << "copying string-CONSTR for ’" << name << "’\n";
  // }
  // explicit Person(std::string &&n) : name(std::move(n)) {
  //   std::cout << "moving string-CONSTR for ’" << name << "’\n";
  // }

  // copy and move constructor:
  Person(Person const &p) : name(p.name) {
    std::cout << "COPY-CONSTR Person ’" << name << "’\n";
  }
  Person(Person &&p) : name(std::move(p.name)) {
    std::cout << "MOVE-CONSTR Person ’" << name << "’\n";
  }
};

int main() {
  std::string s = "sname";
  Person p1(s);     // coping string
  Person p2("tmp"); // moving string
  Person p3(p1);
  Person p4(std::move(p1));
  const Person p2c("ctmp");
  Person p3c(p2c);
}
