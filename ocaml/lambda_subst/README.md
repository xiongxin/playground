# lambda calculus subset

grammar

```
e ::= x | e1 e2 | fun x -> e
v ::= fun x -> e
```

Defining a big-step evaluation relation

```
e1 e2 ==> v
  if e1 ==> fun x -> e
  and e2 ==> v2
  and e{v2/x} ==> v
```

Define the subsitution operation for the lambda calculus.

```
x{e/x} = e
y{e/x} = y
(e1 e2){e/x} = e1{e/x} e2{e/x}
```

函数subsitution operation 有一些复杂

假设我们使用的替换操作为

```
(fun x -> e'){e/x} = fun x -> e'
(fun y -> e'){e/x} = fun y -> e'{e/x}
```

这个定义其实是错误的，他违背了**Principle of Nae Irrelevance**，我们通过一个例子来看看，
考虑函数：

```
(fun z -> x){z/x}
```
使用替换规则:

```
  fun z -> x{z/x}
= fun z -> z
```

可以看出一个不是 identity function 变成了 identity function，再看一个例子

```
(fun y -> x){z/x}
```

结果如下：

```
  fun y -> x{z/x}
= fun y -> z
```


