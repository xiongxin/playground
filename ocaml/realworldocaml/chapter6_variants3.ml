open Base
open Stdio

type 'a expr =
  | Base of 'a
  | Const of bool
  | And of 'a expr list
  | Or of 'a expr list
  | Not of 'a expr

type mail_field =
  | To
  | From
  | CC
  | Date
  | Subject

type mail_predicate =
  { field : mail_field
  ; contains : string
  }

let test field contains = Base { field; contains }

let rec eval expr base_eval =
  (* a shortcut, so we don't need to repeatedly pass [base_eval]
     explicitly to [eval] *)
  let eval' expr = eval expr base_eval in
  match expr with
  | Base base -> base_eval base
  | Const bool -> bool
  | And exprs -> List.for_all exprs ~f:eval'
  | Or exprs -> List.exists exprs ~f:eval'
  | Not expr -> not (eval' expr)
;;

let and_ l =
  if List.exists l ~f:(function
         (* 如果存在一个false 返回 true， 否则返回 false *)
         | Const false -> true
         | _ -> false)
  then Const false
  else (
    match
      (*过滤掉所有true，再评估所有剩下的条件*)
      List.filter l ~f:(function
          | Const true -> false
          | _ -> true)
    with
    | [] -> Const true
    | [ x ] -> x
    | l -> And l)
;;

let or_ l =
  if List.exists l ~f:(function
         | Const true -> true
         | _ -> false)
  then Const true
  else (
    match
      List.filter l ~f:(function
          | Const false -> false
          | _ -> true)
    with
    | [] -> Const false
    | [ x ] -> x
    | l -> Or l)
;;

let not_ = function
  | Const b -> Const (not b)
  | Not e -> e
  | (Base _ | And _ | Or _) as e -> Not e
;;

let rec simplify = function
  | (Base _ | Const _) as x -> x
  | And l -> and_ (List.map ~f:simplify l)
  | Or l -> or_ (List.map ~f:simplify l)
  | Not e -> not_ (simplify e)
;;

let base_eval_string s = String.length s > 0

let () =
  print_endline
    (Bool.to_string
       (eval
          (simplify
             (Not (And [ Or [ Base "it's snowing"; Const true ]; Base "it's raining" ])))
          base_eval_string));
  print_endline
    (Bool.to_string
       (eval
          (simplify
             (Not
                (And
                   [ Or [ Base "it's snowing"; Const true ]
                   ; Not (Not (Base "it's raining"))
                   ])))
          base_eval_string))
;;
