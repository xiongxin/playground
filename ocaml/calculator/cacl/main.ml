open Ast

(** [parse s] parses [s] into an AST. *)
let parse (s : string) : expr =
  let lexbuf = Lexing.from_string s in
  let ast = Parser.prog Lexer.read lexbuf in
  ast
;;

let string_of_val (e : expr) : string =
  match e with
  | Int i -> string_of_int i
  | Binop _ -> failwith "precondition violated"
;;

(** [is_value e] is whether [e] is a value. *)
let is_value : expr -> bool = function
  | Int _ -> true
  | Binop _ -> false
;;

(** [step e] takes a single step of evaluation of [e]. *)
let rec step : expr -> expr = function
  | Int _ -> failwith "Does not step"
  | Binop (bop, e1, e2) when is_value e1 && is_value e2 -> step_bop bop e1 e2
  | Binop (bop, e1, e2) when is_value e1 -> Binop (bop, e1, step e2)
  | Binop (bop, e1, e2) -> Binop (bop, step e1, e2)

(** [step_bop bop v1 v2] implements the primitive operation [v1 bop v2]. 
    Requires: [v1] and [v2] are both values. *)
and step_bop bop v1 v2 =
  match bop, v1, v2 with
  | Add, Int a, Int b -> Int (a + b)
  | Mult, Int a, Int b -> Int (a * b)
  | _ -> failwith "precondition violated"
;;

(** [eval e] fully evaluates [e] to a value [v]. *)
let rec eval (e : expr) : expr = if is_value e then e else e |> step |> eval

(** [interp s] interprets [s] by lexing and parsing it,
    evaluating it, and converting the result to a string. *)
let interp (s : string) : string = s |> parse |> eval |> string_of_val
