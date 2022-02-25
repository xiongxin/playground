
// 简单计算器语法
// program:
//    end
//    expr_list end                  // end is end-of-input
// expr_list:
//    expression print
//    expression print expr_list     // print is newline or semicolon
// expression:
//    expression + term
//    expression − term
//    term
// term:
//    term / primary
//    term ∗ primary
//    primary
// primary:
//    number                          // number is a floating-point literal
//    name                            // name is an identifier
//    name = expression
//    − primary
//    ( expression )
//
//
#include <cctype>
#include <iostream>
#include <map>
#include <sstream>
#include <string>
std::map<std::string, double> table;

enum class Kind : char {
  name,
  number,
  end,
  plus = '+',
  minus = '-',
  mul = '*',
  div = '/',
  print = ';',
  assign = '=',
  lp = '(',
  rp = ')'
};

struct Token {
  Kind kind;
  std::string string_value;
  double number_value;
};

class Token_stream {
public:
  Token_stream(std::istream &s) : ip{&s}, owns{false} {}
  Token_stream(std::istream *p) : ip{p}, owns{true} {}

  ~Token_stream() { close(); }

  Token get();                          // read and return next token
  const Token &current() { return ct; } // most recently read token

  void set_input(std::istream &s) {
    close();
    ip = &s;
    owns = false;
  }

  void set_input(std::istream *p) {
    close();
    ip = p;
    owns = false;
  }

private:
  void close() {
    if (owns)
      delete ip;
  }

  std::istream *ip; // pointer to an input stream
  bool owns;        // does the Token_stream own the istream?
  Token ct{Kind::end};
};

int no_of_errors;

double error(const std::string &s) {
  no_of_errors++;
  std::cerr << "error: " << s << '\n';
  return 1;
}

Token Token_stream::get() {
  char ch = 0;

  do { // skip whitespace except '\n'
    if (!ip->get(ch))
      return ct = {Kind::end};
  } while (ch != '\n' && isspace(ch));

  switch (ch) {
  case 0:
    return ct = {Kind::end};
  case ';': // end of expression; print
  case '\n':
    return ct = {Kind::print};
  case '*':
  case '/':
  case '+':
  case '-':
  case '(':
  case ')':
  case '=':
    return ct = {static_cast<Kind>(ch)};
  case '0':
  case '1':
  case '2':
  case '3':
  case '4':
  case '5':
  case '6':
  case '7':
  case '8':
  case '9':
  case '.':
    ip->putback(ch); // put the first digit (or .) back into the input stream
    *ip >> ct.number_value;
    ct.kind = Kind::number;
    return ct;
  default: // NAME, NAME=, or error
    if (isalpha(ch)) {
      ct.string_value = ch;
      while (ip->get(ch) && isalnum(ch))
        ct.string_value += ch; // append ch to end of string_value
      ip->putback(ch);
      ct.kind = Kind::name;
      return ct;
    }

    error("bad token");
    return ct = {Kind::print};
  }
}

Token_stream ts{std::cin};

double term(bool get);
double prim(bool get);

double expr(bool get) {
  double left = term(get);

  for (;;) {
    switch (ts.current().kind) {
    case Kind::plus:
      left += term(true);
      break;
    case Kind::minus:
      left -= term(true);
      break;
    default:
      return left;
    }
  }
}

double term(bool get) {
  double left = prim(get);

  for (;;) {
    switch (ts.current().kind) {
    case Kind::mul:
      left *= prim(true);
      break;
    case Kind::div:
      if (auto d = prim(true)) {
        left /= d;
        break;
      }

      return error("divide by 0");
    default:
      return left;
    }
  }
}

double prim(bool get) {
  if (get)
    ts.get(); // read next token

  switch (ts.current().kind) {
  case Kind::number: {
    double v = ts.current().number_value;
    ts.get();
    return v;
  }
  case Kind::name: {
    double &v = table[ts.current().string_value];
    if (ts.get().kind == Kind::assign)
      v = expr(true);
    return v;
  }
  case Kind::minus:
    return -prim(true);
  case Kind::lp: {
    auto e = expr(true);
    if (ts.current().kind != Kind::rp)
      return error("')' expected");
    ts.get();
    return e;
  }
  default:
    return error("primary expected");
  }
}

void calculate() {
  for (;;) {
    ts.get();
    if (ts.current().kind == Kind::end)
      break;
    if (ts.current().kind == Kind::print)
      continue;
    std::cout << expr(false) << '\n';
  }
}

int main(int argc, char const *argv[]) {

  switch (argc) {
  case 1:
    break;
  case 2:
    ts.set_input(new std::istringstream(argv[1]));
    break;
  default:
    error("too many arguments");
    return 1;
  }

  table["pi"] = 3.1415926535897932385;
  table["e"] = 2.7182818284590452354;
  // insert predefined names
  calculate();
  return no_of_errors;
}
