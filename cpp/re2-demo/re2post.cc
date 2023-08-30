#include <bits/stdc++.h>
#include <iomanip>
#include <memory>
#include <sstream>
#include <stack>
#include <string_view>
#include <utility>
#include <variant>
#include <vector>

using namespace std;
char *re2post2(const char *re) {
  int nalt, natom;
  static char buf[8000];
  char *dst;
  struct {
    int nalt;
    int natom;
  } paren[100], *p;

  p = paren;
  dst = buf;
  nalt = 0;
  natom = 0;
  if (strlen(re) >= sizeof buf / 2)
    return NULL;
  for (; *re; re++) {
    switch (*re) {
    case '(':
      if (natom > 1) {
        --natom;
        *dst++ = '.';
      }
      if (p >= paren + 100)
        return NULL;
      p->nalt = nalt;
      p->natom = natom;
      p++;
      nalt = 0;
      natom = 0;
      break;
    case '|':
      if (natom == 0)
        return NULL;
      while (--natom > 0)
        *dst++ = '.';
      nalt++;
      break;
    case ')':
      if (p == paren)
        return NULL;
      if (natom == 0)
        return NULL;
      while (--natom > 0)
        *dst++ = '.';
      for (; nalt > 0; nalt--)
        *dst++ = '|';
      --p;
      nalt = p->nalt;
      natom = p->natom;
      natom++;
      break;
    case '*':
    case '+':
    case '?':
      if (natom == 0)
        return NULL;
      *dst++ = *re;
      break;
    default:
      if (natom > 1) {
        --natom;
        *dst++ = '.';
      }
      *dst++ = *re;
      natom++;
      break;
    }
  }
  if (p != paren)
    return NULL;
  while (--natom > 0)
    *dst++ = '.';
  for (; nalt > 0; nalt--)
    *dst++ = '|';
  *dst = 0;
  return buf;
}
/*
 * Convert infix regexp re to postfix notation.
 * Insert . as explicit concatenation operator.
 * Cheesy parser, return static buffer.
 */
string re2post(string_view re) {
  stringstream ss{};
  // # of alternation, # of atom
  int nalt{0}, natom{0};
  stack<pair<int, int>> paren{};

  for (char c : re) {
    switch (c) {
    case '(':
      if (natom > 1) {
        --natom;
        ss << '.';
      }

      paren.push({nalt, natom});

      nalt = 0;
      natom = 0;
      break;
    case '|':
      if (natom == 0)
        return {};
      while (--natom > 0)
        ss << '.';

      ++nalt;
      break;
    case ')': {
      if (paren.empty() || natom == 0)
        return {};

      while (--natom > 0)
        ss << '.';

      for (; nalt > 0; --nalt)
        ss << '|';

      pair p = paren.top();
      nalt = p.first;
      natom = p.second;
      ++natom;
      paren.pop();
      break;
    }
    case '*':
    case '+':
    case '?':
      if (natom == 0)
        return {};
      ss << c;
      break;
    default:
      if (natom > 1) {
        --natom;
        ss << '.';
      }
      ss << c;
      ++natom;
      break;
    }
  }
  while (--natom > 0)
    ss << '.';

  for (; nalt > 0; nalt--)
    ss << '|';
  return ss.str();
}

enum { Match = 256, Split = 257 };

struct State {
  int c;
  unique_ptr<State> out;
  unique_ptr<State> out1;
  int lastlist;
};

struct Parlist;
using Parlist = variant<unique_ptr<State>, unique_ptr<Parlist>>;

struct Frag {
  int c;
  unique_ptr<State> start;
  int lastlist;
};

/*
 * Convert postfix regular expression to NFA.
 * Return start state.
 */
State *post2nfa(char *postfix) {}

int main() {
  const char *input = "(abc|def)";
  cout << re2post(input) << '\n';
  cout << re2post2(input) << '\n';
  cout << (re2post(input) == re2post2(input)) << '\n';
  return 0;
}
