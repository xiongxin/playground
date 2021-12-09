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

- *Evaluation* is the process of continuing to simplify the AST unit
it's just a value.

