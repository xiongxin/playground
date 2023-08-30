#include <bits/stdc++.h>

using namespace std;
/**
https://brilliant.org/wiki/shunting-yard-algorithm/
While there are tokens to be read:
  Read a token
  If it's a number add it to queue
  If it's an operator
    While there's an operator on the top of the stack with greater precedence:
      Pop operators from the stack onto the output queue
    Push the current operator onto the stack
  If it's a left bracket push it onto the stack
  If it's a right bracket
    While there's not a left bracket at the top of the stack:
      Pop operators from the stack onto the output queue.
    Pop the left bracket from the stack and discard it
While there are operators on the stack, pop them to the queue
*/
string shuting_yard(string_view input) {
  stringstream ss{};
  stack<char> oper_stack;
  map<char, int> precedences{{'-', 0}, {'+', 0}, {'/', 1}};
  for (char c : input) {

    if (isalnum(c)) {
      ss << c << ' ';
    }

    if (c == '+' || c == '/' || c == '-') {
      while (!oper_stack.empty() &&
             precedences[oper_stack.top()] > precedences[c]) {
        ss << oper_stack.top() << ' ';
        oper_stack.pop();
      }

      oper_stack.push(c);
    }

    if (c == '(')
      oper_stack.push(c);

    if (c == ')') {
      while (oper_stack.top() != '(') {
        ss << oper_stack.top() << ' ';
        oper_stack.pop();
      }
      oper_stack.pop();
    }
  }

  while (!oper_stack.empty()) {
    ss << oper_stack.top() << ' ';
    oper_stack.pop();
  }

  return ss.str();
}

int main() {
  cout << shuting_yard("4+8/(9-3)") << '\n';
  return 0;
}
