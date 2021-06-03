
# Source Analysis

The first stage of compilation for a Rust program is tokenisation.

- Identifiers foo bar
- Integers 42
- Keywords _, fn , self
- Lifetimes 'a
- Strings: ""
- Symbols: [, :, ::, -> , @, <- 

Notes:

- self is both an identifer and a keyword
- the list of symbols also includes entries that aren't used by the language. In 
the case of <- , it is vestigial: it was removed from the grammar, but not from the 
- :: is a distinct token; it is not simply two adjacent : tokens.


The next stage is parsing, where the stream of tokens is turned into an Abstract Syntax Tree
(AST). This involves building up the syntactic structure of the program in memory.

The AST contains the structure of the entire program, though it is based on purely lexical 
information. For example, although the compiler may know that a particular expression is 
referring to variable called "a", at this stage, it has no way of knowing what "a" is, or
even where it comes from.

It is after the AST has been constructed that macros are processed. However, before we
can discuss that, we have to talk about token trees.


## Token trees

Token trees are somewhere between tokens and the AST. Firstly, almost all tokens are
also token trees; more specifically, they are leaves. There is one other kind of thing
that can be a token tree leaf, but we will come back to that later.

The only basic tokens that are not leaves are the "grouping" tokens: (...), [...], and {...}
. These three are the interior nodes of tokens trees, and what give them their structure.
To give a concrete example, this sequence of tokens:

```
a + b + (c + d[0]) + e
```

would be parsed into the following token trees:

```
«a» «+» «b» «+» «(   )» «+» «e»
          ╭────────┴──────────╮
           «c» «+» «d» «[   ]»
                        ╭─┴─╮
                         «0»                                     
```

Note that this has no relationship to the AST the expression would produce; instead of
a single root node, there are nine token trees at the root level. For reference, the AST
would be:

```
              ┌─────────┐
              │ BinOp   │
              │ op: Add │
            ┌╴│ lhs: ◌  │
┌─────────┐ │ │ rhs: ◌  │╶┐ ┌─────────┐
│ Var     │╶┘ └─────────┘ └╴│ BinOp   │
│ name: a │                 │ op: Add │
└─────────┘               ┌╴│ lhs: ◌  │
              ┌─────────┐ │ │ rhs: ◌  │╶┐ ┌─────────┐
              │ Var     │╶┘ └─────────┘ └╴│ BinOp   │
              │ name: b │                 │ op: Add │
              └─────────┘               ┌╴│ lhs: ◌  │
                            ┌─────────┐ │ │ rhs: ◌  │╶┐ ┌─────────┐
                            │ BinOp   │╶┘ └─────────┘ └╴│ Var     │
                            │ op: Add │                 │ name: e │
                          ┌╴│ lhs: ◌  │                 └─────────┘
              ┌─────────┐ │ │ rhs: ◌  │╶┐ ┌─────────┐
              │ Var     │╶┘ └─────────┘ └╴│ Index   │
              │ name: c │               ┌╴│ arr: ◌  │
              └─────────┘   ┌─────────┐ │ │ ind: ◌  │╶┐ ┌─────────┐
                            │ Var     │╶┘ └─────────┘ └╴│ LitInt  │
                            │ name: d │                 │ val: 0  │
                            └─────────┘                 └─────────┘
```

It is import to undeerstand the distinction between the AST and token trees. When writing
macros, you have to deal with both as distinct things.

On other aspect of this to note: it is impossible to have an unpaired paren, bracket or brace; nor is it possible to have incorrectly nested groups in a token tree.

# Macros in the AST

As previously mentioned, macro processing in Rust happens after the construction of the AST.
As such, the syntax used to invoke a macro must be a proper part of the language's syntax.
In fact, there are several "syntax extension" forms which are part of Rust's syntax.
Specifically, the following forms (by way of examples):

- `# [ $arg ] `; e.g. `#[derive(Clione)], #[no_mangle]`
- `# ! [ $arg ] ` e.g. `#![allow(dead_code)]`, `#![create_name="blang"]`, ...
- `$name ! !arg`; e.g. `println!("Hi")`, `concat!("a", "b")`, ...
- `$name ! $arg0 $arg1`; e.g. `macro_rules! dummy { () => {}; }`.



item: anything.
block: anything.
stmt: => , ;
pat: => , = if in
expr: => , ;
ty: , => : = > ; as
ident: anything.
path: , => : = > ; as
meta: anything.
tt: anything.