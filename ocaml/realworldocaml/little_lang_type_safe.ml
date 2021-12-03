open Base

type value = Int of int | Bool of bool

type expr =
  | Value of value
  | Eq of expr * expr
  | Plus of expr * expr
  | If of expr * expr * expr

exception Ill_typed

let rec eval expr =
  match expr with
  | Value v -> v
  | If (c, t, e) -> (
      match eval c with
      | Bool b -> if b then eval t else eval e
      | _ -> raise Ill_typed)
  | Eq (x, y) -> (
      match (eval x, eval y) with
      | Bool _, _ | _, Bool _ -> raise Ill_typed
      | Int f1, Int f2 -> Bool (f1 = f2))
  | Plus (x, y) -> (
      match (eval x, eval y) with
      | Bool _, _ | _, Bool _ -> raise Ill_typed
      | Int f1, Int f2 -> Int (f1 + f2))

let i x = Value (Int x)

and b x = Value (Bool x)

and ( +: ) x y = Plus (x, y)

module type Typesafe_lang_sig = sig
  type 'a t

  (** functions for constructing expressions *)

  val int : int -> int t

  val bool : bool -> bool t

  val if_ : bool t -> 'a t -> 'a t -> 'a t

  val eq : 'a t -> 'a t -> bool t

  val plus : int t -> int t -> int t

  (** Evaluation functions *)

  val int_eval : int t -> int

  val bool_eval : bool t -> bool
end

module Typesafe_lang : Typesafe_lang_sig = struct
  type 'a t = expr

  let int x = Value (Int x)

  let bool x = Value (Bool x)

  let if_ c t e = If (c, t, e)

  let eq x y = Eq (x, y)

  let plus x y = Plus (x, y)

  let int_eval expr =
    match eval expr with Int x -> x | Bool _ -> raise Ill_typed

  let bool_eval expr =
    match eval expr with Bool x -> x | Int _ -> raise Ill_typed
end
