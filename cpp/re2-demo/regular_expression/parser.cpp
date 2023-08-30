#include "parser.hpp"
#include <sstream>
#include <stack>
#include <string>
#include <string_view>

using namespace std;

static map<char, int> precedencs = {
    {'|', 0}, {'.', 1}, {'?', 2}, {'*', 2}, {'+', 2},
};

string insert_explicit_concat_operator(string_view exp) {
  stringstream ss;

  for (string_view::size_type i = 0; i < exp.length(); ++i) {
    char token = exp[i];
    ss << token;

    if (token == '(' || token == '|')
      continue;

    if (i < exp.length() - 1) {
      char lookahead = exp[i + 1];

      if (lookahead == '*' || lookahead == '?' || lookahead == '+' ||
          lookahead == '|' || lookahead == ')')
        continue;

      ss << '.';
    }
  }

  return ss.str();
}

string to_postfix(string_view exp) {
  stringstream ss;
  stack<char> operator_stack;

  auto peek = [&]() {
    if (operator_stack.size()) {
      return operator_stack.top();
    } else {
      return (char)0;
    }
  };

  for (char token : exp) {

    if (token == '.' || token == '|' || token == '*' || token == '?' ||
        token == '+') {
      while (operator_stack.size() && peek() != '(' &&
             precedencs[peek()] >= precedencs[token]) {
        ss << operator_stack.top();
        operator_stack.pop();
      }

      operator_stack.push(token);
    } else if (token == '(' || token == ')') {
      if (token == '(') {
        operator_stack.push(token);
      } else {
        while (peek() != '(') {
          ss << operator_stack.top();
          operator_stack.pop();
        }

        operator_stack.pop();
      }
    } else {
      ss << token;
    }
  }

  while (operator_stack.size()) {
    ss << operator_stack.top();
    operator_stack.pop();
  }

  return ss.str();
}
