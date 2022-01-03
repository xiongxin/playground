import std.stdio;
import std.random;
import std.algorithm;
import std.exception;

void main(string[] args) {
  myTemplate(&myFunction);

  auto o = MyStruct();
  auto f = &MyStruct.func; // on a type
  auto d = &o.func; // on an object

  static assert(is(typeof(f) == void function()));
  static assert(is(typeof(d) == void delegate()));

  CalculationFunc ptr = &myFunction;
  int result = ptr('a', 5.67);
  assert(result == 42);

  int[] numbers;

  foreach (i; 0 .. 10) {
    numbers ~= uniform(0, 10) - 5;
  }

  writeln("input: ", numbers);
  int[] output = filterAndConvert(numbers);
  writeln("address of output: ", output.ptr);
  writeln("output:", filterAndConvert(numbers));
  writeln("output:", filterAndConvert(numbers, &isGreaterThanZero, &tenTimes));
  writeln("output:", filterAndConvert(numbers, number => number > 0, number => number * 10));

  auto handler = new NumberHandler(&isGreaterThanZero, &tenTimes);
  writeln("result: ", handler.handle(numbers));

  new NumberHandler(function bool(int number) { return number > 2; }, function int(int number) {
    return number * 7;
  });

  foo(function double() { return 42.42; });
  foo(function() { return 42.2; });
  foo(function{ return 42.2; });
  foo({ return 42.3; });

  writeln(numbers.filter!(number => number > 10));

  auto r = binaryAlgorithm((l, r) => l + r, [1, 2, 3], [1, 2, 3]);

  auto calculator = makeCalculator();
  writeln("The result of the calculation: ", calculator(3));
  int lastNumber;
  writeln(delimitedNumbers(3, () => 32));
  writeln(delimitedNumbers(3, () => lastNumber + uniform(0, 3)));

  auto location = Location();
  writeln(typeof(&location.moveHorizontally).stringof);

  auto directionFunction = &location.moveHorizontally;
  directionFunction(3);
  writeln(location);
}

alias CalculationFunc = int function(char, double);
alias Predicate = bool function(int);
alias Convertor = int function(int);

void foo(double function() func) {

}

int myFunction(char c, double d) {
  return 42;
}

void myTemplate(T)(T parameter) {
  writeln("type: ", T.stringof);
  writeln("value: ", parameter);
}

struct MyStruct {
  void func() {
  }
}

interface Employee {
  double wages();
}

class FullTimeEmployee : Employee {
  double wages() {
    double result;

    return result;
  }
}

class HourlyEmployee : Employee {
  double wages() {
    double result;
    // ...
    return result;
  }
}

bool isGreaterThanZero(int number) {
  return number > 0;
}

int tenTimes(int number) {
  return number * 10;
}

int[] filterAndConvert(const int[] numbers) {
  int[] result;

  foreach (e; numbers) {
    if (e > 0) {
      immutable newNumber = e * 10;
      result ~= newNumber;
    }
  }
  writeln("address of result: ", result.ptr);
  return result;
}

int[] filterAndConvert(const int[] numbers, Predicate predicate, Convertor convertor) {
  int[] result;

  foreach (e; numbers) {
    if (predicate(e)) {
      immutable newNumber = convertor(e);
      result ~= newNumber;
    }
  }

  return result;
}

class NumberHandler {
  Predicate predicate;
  Convertor convertor;

  this(Predicate predicate, Convertor convertor) {
    this.predicate = predicate;
    this.convertor = convertor;
  }

  int[] handle(const int[] numbers) {
    int[] result;

    foreach (number; numbers) {
      if (predicate(number)) {
        immutable newNumber = convertor(number);
        result ~= newNumber;
      }
    }

    return result;
  }
}

int[] binaryAlgorithm(int function(int, int) func, const int[] slice1, const int[] slice2) {
  enforce(slice1.length == slice2.length);

  int[] results;

  foreach (i; 0 .. slice1.length) {
    results ~= func(slice1[i], slice2[i]);
  }

  return results;
}

alias Calculator = int delegate(int);
Calculator makeCalculator() {
  int increment = 10;
  return value => increment + value;
}

int[] delimitedNumbers(int count, int delegate() numberGenerator) {
  int[] result = [-1];
  result.reserve(count + 2);

  foreach (i; 0 .. count) {
    result ~= numberGenerator();
  }

  result ~= -1;

  return result;
}

struct Location {
  long x;
  long y;

  void moveHorizontally(long step) {
    x += step;
  }

  void moveVertically(long step) {
    y += step;
  }
}
