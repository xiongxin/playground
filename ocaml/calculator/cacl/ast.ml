type binop =
  | Add
  | Mult

type expr =
  | Int of int
  | Binop of binop * expr * expr
