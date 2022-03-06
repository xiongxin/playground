type expr =
  | Plus of expr * expr (* a + b *)
  | Minus of expr * expr (* a - b *)
  | Times of expr * expr (* a * b *)
  | Divide of expr * expr (* a / b *)
  | Var of string
(* "x", "y", etc. *)

let rec to_string e =
  match e with
  | Plus (left, right) -> "(" ^ to_string left ^ " + " ^ to_string right ^ ")"
  | Minus (left, right) -> "(" ^ to_string left ^ " - " ^ to_string right ^ ")"
  | Times (left, right) -> "(" ^ to_string left ^ " * " ^ to_string right ^ ")"
  | Divide (left, right) -> "(" ^ to_string left ^ " / " ^ to_string right ^ ")"
  | Var v -> v

let rec multiply_out e =
  match e with
  | Times (e1, Plus (e2, e3)) ->
      Plus
        ( Times (multiply_out e1, multiply_out e2),
          Times (multiply_out e1, multiply_out e3) )
  | Times (Plus (e1, e2), e3) ->
      Plus
        ( Times (multiply_out e1, multiply_out e3),
          Times (multiply_out e2, multiply_out e3) )
  | Plus (left, right) -> Plus (multiply_out left, multiply_out right)
  | Minus (left, right) -> Minus (multiply_out left, multiply_out right)
  | Times (left, right) -> Times (multiply_out left, multiply_out right)
  | Divide (left, right) -> Divide (multiply_out left, multiply_out right)
  | Var v -> Var v

let print_expr e = print_endline (to_string e);;

print_expr (Times (Var "n", Plus (Var "x", Var "y")));;
print_expr (multiply_out (Times (Var "n", Plus (Var "x", Var "y"))))
