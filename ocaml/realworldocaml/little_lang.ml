open Base
open Stdio

type value =
  | Int of int
  | Bool of bool

type expr =
  | Value of value
  | Eq of expr * expr
  | Plus of expr * expr
  | If of expr * expr * expr

exception Ill_typed

let rec eval expr =
  match expr with
  | Value v -> v
  | If (c, t, e) ->
    (match eval c with
    | Bool b -> if b then eval t else eval e
    | _ -> raise Ill_typed)
  | Eq (x, y) ->
    (match eval x, eval y with
    | Bool _, _ | _, Bool _ -> raise Ill_typed
    | Int f1, Int f2 -> Bool (f1 = f2))
  | Plus (x, y) ->
    (match eval x, eval y with
    | Bool _, _ | _, Bool _ -> raise Ill_typed
    | Int f1, Int f2 -> Int (f1 + f2))
;;

let i x = Value (Int x)
and b x = Value (Bool x)
and ( +: ) x y = Plus (x, y)

let () =
  let a = eval (i 3 +: b false) in
  match a with
  | Int i -> print_endline (Int.to_string i)
  | Bool i -> print_endline (Bool.to_string i)
;;
