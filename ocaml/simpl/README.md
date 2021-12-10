```
e ::= x | i | b | e1 bop e2
    | if e1 then e2 else e3
    | let x = e1 in e2

bop ::= + | * | <=

x ::= <identifiers>

i ::= <integers>

b ::= true | false

v ::= i | b
```

## Substitution Model

**Big vs. small step evaluation.**
- The first, -->, will represent how a program takes one single step of execution.
- The second, -->*, is the reflexive transitive closure of -->, and it represents how a program takes multiple steps of execution.
- The third, ==>, abstracts away from all the details of single steps and represents how a program reduces directly to a value.

**Relating big and small steps**: For all expressions e and values v, it holds that e -->* v if and only if e ==> v.

**Substitution vs. environment models.**

- We could eagerly substitute the value of a variable for its name throughout the scope of that name, as soon as we finding a binding of the variable.

- We could lazily record the substitution in a dictionary, which is usually called an environment when used for this purpose, and we could look up the variable’s value in that environment whenever we find its name mentioned in a scope.

SimPL采用**small-step substitution-model semantics**

**Constants**.Integer and Boolean constants are already values, so they cannot take a step.使用符号-/->表示
- i -/->
- b -/->

**Binary operators**

```
e1 bop e2 --> e1' bop e2
  if e1 --> e1'

v1 bop e2 --> v1 bop e2'
  if e2 --> e2'

v1 bop v2 --> v
  if v is the result of primitive operation v1 bop v2
```

EX:
```
    (3*1000) + ((1*100) + ((1*10) + 0))
--> 3000 + ((1*100) + ((1*10) + 0))
--> 3000 + (100 + ((1*10) + 0))
--> 3000 + (100 + (10 + 0))
--> 3000 + (100 + 10)
--> 3000 + 110
--> 3110
```

**If expressions**


First,the guard is evaluated to a value:

```
if e1 then e2 else e3 --> if e1' then e2 else e3
  if e1 --> e1'
```
Then, based on the guard, the if expression is simplified to just one of the branches:

```
if true then e2 else e3 --> e2

if false then e2 else e3 --> e3
```

**Let expressions**:first the binding expression, then the body.

The rule that steps the binding expression is:

```
let x = e1 in e2 --> let x = e1' in e2
  if e1 --> e1'
```

Next, if the binding expression has reached a value,we want to subsitute that value for
the name of the variable in the body expression:

```
let x = v1 in e2 --> e2 with v1 substituted for x
```
EX: `let x = 42 in x + 1` should step to `42 + 1`, 
because substituting `42` for `x` in `x + 1` yields `42 + 1`.


let’s assume a new notation: `e'{e/x}`, which means, "the expression `e'` with `e`
subsituting `32` for `x`"

```
let x = v1 in e2 --> e2{v1/x}
```

**Variables**