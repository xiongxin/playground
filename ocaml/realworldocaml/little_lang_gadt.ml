open Base
open Stdio

type _ value =
  | Int : int -> int value
  | Bool : bool -> bool value

type _ expr =
  | Value : 'a value -> 'a expr
  | Eq : int expr * int expr -> bool expr
  | Plus : int expr * int expr -> int expr
  | If : bool expr * 'a expr * 'a expr -> 'a expr

let i x = Value (Int x)
and b x = Value (Bool x)
and ( +: ) x y = Plus (x, y)

let eval_value : type a. a value -> a = function
  | Int x -> x
  | Bool x -> x
;;

let rec eval : type a. a expr -> a = function
  | Value v -> eval_value v
  | If (c, t, e) -> if eval c then eval t else eval e
  | Eq (x, y) -> eval x = eval y
  | Plus (x, y) -> eval x + eval y
;;

let () =
  let i = eval (i 3 +: i 4000) in
  print_endline (Int.to_string i)
;;
