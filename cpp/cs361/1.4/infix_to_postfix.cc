// 1. 字符的话直接输出
// 2. 操作符先放入栈中，只有发现最新操作符比栈顶操作符
//    优先级低时才将栈中的操作符输出，优先级顺序高到低 (  */  +-  )

#include <bits/stdc++.h>

using namespace std;

static map<char, int> precedences = {{'*', 2}, {'/', 2}, {'+', 1}, {'-', 1}};

void conv(const string& str) {
  stack<char> _stack{};

  for (const char& c : str) {
    // If the scanned character is an operand, output it, i.e. print it
    if (isalpha(c) || isalnum(c) || c == ' ') {
      cout << c;
    } else if (c == '(') {
      _stack.push(c);
    } else if (c == ')') {
      while (_stack.top() != '(') {
        cout << _stack.top();
        _stack.pop();
      }
      _stack.pop();
    } else {
      if (_stack.empty() || precedences[c] > precedences[_stack.top()]) {
        _stack.push(c);
      } else {
        while (!_stack.empty() && _stack.top() != '(') {
          cout << _stack.top();
          _stack.pop();
        }
        _stack.push(c);
      }
    }
  }

  while (!_stack.empty()) {
    cout << _stack.top();
    _stack.pop();
  }
  cout << '\n';
}

int main(int argc, char const* argv[]) {
  conv("(1+(4+5+2)-3)+(6+8)");
  return 0;
}
