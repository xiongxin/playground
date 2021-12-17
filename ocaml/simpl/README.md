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

Note how the let expression rule eliminates a variable from showing up in the body
expression: the variable's name is replaced by the value that variable should have.
So, we should never reach the point of attempting to step a variable name-assuming
that the program was well typed.

## Implementing hte Single-Step Reation

```ocaml
(** [is_value e] is whether [e] is a value. *)
let is_value : expr -> bool = function
  | Int _ | Bool _ -> true
  | Var _ | Let _ | Binop _ | If _ -> false

(** [subst e v x] is [e{v/x}]. *)
let subst e v x =
  failwith "See next section"

(** [step] is the [-->] relation, that is, a single step of
    evaluation. *)
let rec step : expr -> expr = function
  | Int _ | Bool _ -> failwith "Does not step"
  | Var _ -> failwith "Unbound variable"
  | Binop (bop, e1, e2) when is_value e1 && is_value e2 ->
    step_bop bop e1 e2
  | Binop (bop, e1, e2) when is_value e1 ->
    Binop (bop, e1, step e2)
  | Binop (bop, e1, e2) -> Binop (bop, step e1, e2)
  | Let (x, e1, e2) when is_value e1 -> subst e2 e1 x
  | Let (x, e1, e2) -> Let (x, step e1, e2)
  | If (Bool true, e2, _) -> e2
  | If (Bool false, _, e3) -> e3
  | If (Int _, _, _) -> failwith "Guard of if must have type bool"
  | If (e1, e2, e3) -> If (step e1, e2, e3)

(** [step_bop bop v1 v2] implements the primitive operation
    [v1 bop v2].  Requires: [v1] and [v2] are both values. *)
and step_bop bop e1 e2 = match bop, e1, e2 with
  | Add, Int a, Int b -> Int (a + b)
  | Mult, Int a, Int b -> Int (a * b)
  | Leq, Int a, Int b -> Bool (a <= b)
  | _ -> failwith "Operator and operand type mismatch"
```

### The Multistep Relation

`-->*` is just the reflexive transitive closure of `-->`. In other words,
it can be defined with just these two rules:

```
e -->* e

e -->* e''
  if e --> e' and e' -->* e''
```

我们的感兴趣的子关系是 `e -->* v`，右边不再是表达式，我们可以使用递归来实现：

```ocaml
(** [eval_small e] is the [e -->* v] relation.  That is,
    keep applying [step] until a value is produced.  *)
let rec eval_small (e : expr) : expr =
  if is_value e then e
  else e |> step |> eval_small
```

### Defining the Big-Step Relation

定义大步关系 `==>` 与多步关系一致 `-->*`。

**Constants** are easy, beacause they big-step to themselves.

```
i ==> i
b ==> b
```

**Binary operators** just big-step both of their subexpressions, they apply whatever
the primitive operator is:

```
e1 bop e2 ==> v
  if e1 ==> v1
  if e2 ==> v2
  and v is the result of primitive operation v1 bop v2
```

**If expressions** big step the guard, then big step one of the branches:

```
if e1 then e2 else e3 ==> v2
  if e1 ==> true
  and e2 ==> v2

if e1 then e2 else e3 ==> v3
  if e1 ==> false
  and e3 ==> v3
```

**Let expressions** big step the binding expression, do a subsitution, and big
step the result of the substitution:

```
let x = e1 in e2 ==> v2
  if e1 ==> v1
  and e2{v1/x} ==> v2
```

Finally, variables do not big step, for the same reason as with the samll step
semantics--a welltyped program with never reach the point of attempting to
evaluate a variable name:

```
x =/=>
```

### Implementing the Big-Step Relation

```ocaml
(** [eval_big e] is the [e ==> v] relation. *)
let rec eval_big (e : expr) : expr = match e with
  | Int _ | Bool _ -> e
  | Var _ -> failwith "Unbound variable"
  | Binop (bop, e1, e2) -> eval_bop bop e1 e2
  | Let (x, e1, e2) -> subst e2 (eval_big e1) x |> eval_big
  | If (e1, e2, e3) -> eval_if e1 e2 e3

(** [eval_bop bop e1 e2] is the [e] such that [e1 bop e2 ==> e]. *)
and eval_bop bop e1 e2 = match bop, eval_big e1, eval_big e2 with
  | Add, Int a, Int b -> Int (a + b)
  | Mult, Int a, Int b -> Int (a * b)
  | Leq, Int a, Int b -> Bool (a <= b)
  | _ -> failwith "Operator and operand type mismatch"

(** [eval_if e1 e2 e3] is the [e] such that [if e1 then e2 else e3 ==> e]. *)
and eval_if e1 e2 e3 = match eval_big e1 with
  | Bool true -> eval_big e2
  | Bool false -> eval_big e3
  | _ -> failwith "Guard of if must have type bool"
```


### Subsitution in SimPL

`e'{e/x}` 将表达式`e'`中的`e`使用`x`替换。

**Constants** have no variables appearing in them (e.g., `x` cannot syntactically occur in `42`),
so substitution leaves them unchanged:

```
i{e/x} = i
b{e/x} = b
```

**Binary operators and if expressions**, all that substitution needs to do is to recurse inside
the subexpressions:

```
(e1 bop e e2){e/x} = e1{e/x} bop e2{e/x}
(if e1 then e2 else e3){e/x} = if e1{e/x} then e2{e/x} else e3{e/x}
```

**Variables** start to get a litter trickier.

```
x{e/x} = e
y{e/x} = y
```

EX: `(x + 42){1/x}`

```
  (x + 42){1/x}
= x{1/x} + 42{1/x}   by the bop case
= 1 + 42{1/x}        by the first variable case
= 1 + 42             by the integer case
```

注意：再执行替换时，我们时没有定义 `-->`关系的，没有相等的代表单步eval。假设我们
eval `let x = 1 in x + 42`:

```
  let x = 1 in x + 42
--> (x + 42){1/x}
  = 1 + 42
--> 43
```

**Let expression** also have two cases, depending on the name of the bound variable:

```
(let x = e1 in e2){e/x} = let x = e1{e/x} in e2            -- 这里是因为 shadowing name的问题
(let y = e1 in e2){e/x} = let y = e1{e/x} in e2{e/x}
```

Both of those cases subsitute `e` for `x` inside the binding expression `e1`. That's to
ensure that expressions like `let x = 42 in let y = x in y`

EX: `let x = 5 in let x = 6 in x`

```
    let x = 5 in let x = 6 in x
--> (let x = 6 in x){5/x}
  = let x = 6{5/x} in x      ***
  = let x = 6 in x
--> x{6/x}
  = 6
```

On the line tagged `***`,we’ve stopped substituting inside the body expression, because we reached a shadowed variable name. 

```
    let x = 5 in let x = 6 in x
--> (let x = 6 in x){5/x}
  = let x = 6{5/x} in x{5/x}      ***WRONG***
  = let x = 6 in 5
--> 5{6/x}
  = 5
```

EX: `let x = 2 in x +1`

```
let x = 2 in x + 1
--> (x+1){2/x}
  = 2 + 1
--> 3
```

EX: `let x = 0 in let x = 1 in x`

```
let x = 0 in let x = 1 in x
--> (let x = 1 in x){0/x}   -- 出现shadowing name
  = (let x = 1{0/x} in x)
  = (let x = 1 in x)
--> x{1/x}
  = 1
```

EX: `let x = 0 in x + (let x = 1 in x)`

```
let x = 0 in x + (let x = 1 in x)
--> (x + (let x = 1 in x)){0/x}
  = x{0/x} + (let x = 1 in x){0/x}
  = 0 + (let x = 1{0/x} in x)
  = 0 + (let x = 1 in x)
--> 0 + x{1/x}
  = 0 + 1
--> 1
