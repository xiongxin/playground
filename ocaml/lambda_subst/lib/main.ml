open Ast

let parse (s : string) : expr =
  let lexbuf = Lexing.from_string s in
  let ast = Parser.prog Lexer.read lexbuf in
  ast
;;

(** [is_value e] is whether [e] is a value. *)
let is_value : expr -> bool = function
  | Fun _ -> true
  | Var _ | App _ -> false
;;

module VarSet = Set.Make (String)

let singleton = VarSet.singleton
let union = VarSet.union
let diff = VarSet.diff
let mem = VarSet.mem

(** [fv e] is a set-like list of the free variables of [e]. *)
let rec fv : expr -> VarSet.t = function
  | Var x -> singleton x
  | App (e1, e2) -> union (fv e1) (fv e2)
  | Fun (x, e) -> diff (fv e) (singleton x)
;;
