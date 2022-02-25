# The code of The C++ Programming Language

## Introductroy Material

### 2.A Tour of C++: The Basics

A *declaration* is a statement that introduces a name into the program. It specifies a type for the
named entity:
- A *type* defines a set of possible values and a set of operations (for an object).
- An *object* is some memory that holds a value of some type.
- A *value* is a set of bits interpreted according to a type.
- A *variable* is a named object.


**初始化表达式**
C++提供广泛的初始化表达式，例如 `=`，和使用统一的大括号初始化列表：

```c++
double d1 = 2.3;
double d2 {2.3};
complex<double> z = 1;          // a complex number with double-precision floating-point scalars
complex<double> z2 {d1,d2};
complex<double> z3 = {1,2};     // the = is optional with { ... }


vector<int> v {1,2,3,4,5,6};    // a vector of ints
```

初始化列表不会出现类型转换：

```c++
int i1 = 7.2;       // i1 becomes 7
int i2 {7.2};       // error : floating-point to integer conversion
int i3 = {7.2};     // error : floating-point to integer conversion (the = is redundant)
```

**declarator operators**:
- `T a[n]` array of n Ts
- `T* p` pointer to T
- `T& r` reference to T
- `T f(A)` function takeing an argument of type A returning a result of type T

### 3 Abstraction Mechainisms

- Concrete classes
- Abstract classes
- classes in class hierarchies

**Functions defined in a class are inlined by default. **

**virtual** means "may be redefined later in a class derived from this one."
`=0` syntax says the function is pure virtual; that is, some class derived
from `Container` must define the function. A class with a pure virtual function
is called an abstract class.

虚方法调用，调用者仅仅需要知道父类的`vtbl`的指针位置，索引调用每个虚方法。

**Resource handle**带有指针的对象

**this** is predefined in a member function and points to the object for which the member
function is called.

**&&** means "rvalue reference" and is a reference to which we can bind an rvalue.
**lvalue** means "something that can appear on the left-hand side of an assignment."
So an rvalue is - to a first approximation - a value that you can't assign to,
such as an integer returned by a function call, and an rvalue reference is a 
reference to something that nobody else can assign to. The `res` ocal variable
in `operator+()` for `Vector`s is an example.

#### Copy and Move

```c++
void test(complex z1)
{
    complex z2 {z1}; // copy initialization
    complex z3;
    z3 = z2; // copy assignment
}


Vector f()
{
    Vector x(1000);
    Vector y(1000);
    Vector z(1000);
    // ...
    z = x;             // we get a copy
    y = std::move(x);  // we get a move
    // ...
    return z;          // we get a move
};

```

**move** 资源转移到新的数据上，避免复制操作。

## Constant Expressions

CPP offers two related meaning of "constant":
- constexpr: Evaluate at compile time
- const: Do not modify in this scope

