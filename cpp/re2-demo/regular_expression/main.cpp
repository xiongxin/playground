#include "nfa.hpp"
#include "parser.hpp"
#include <algorithm>
#include <iostream>

int main() {

  block a = from_symbol('a');

  std::cout << insert_explicit_concat_operator("(abc|def)*c?") << '\n';
  std::cout << to_postfix(insert_explicit_concat_operator("(abc|def)*c?"))
            << '\n';
  std::cout << search(to_nfa(to_postfix(
                          insert_explicit_concat_operator("(abc|def)*"))),
                      "abcabcdef")
            << '\n';
  return 0;
}
