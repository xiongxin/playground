(**Doubly Linked Lists *)

open Base

(* the type of a list *)
type 'a t

(*  the type of an element *)
type 'a element

(* Basic list iperations *)
val create : unit -> 'a t
val is_empty : 'a t -> bool

(** Nativgation using [Element]s *)
val first : 'a t -> 'a element option

val next : 'a element -> 'a element option
val prev : 'a element -> 'a element option
val value : 'a element -> 'a

(** Whole-data-structure iteration *)
val iter : 'a t -> f:('a -> unit) -> unit

val find_el : 'a t -> f:('a -> bool) -> 'a element option

(** Mutation *)
val insert_first : 'a t -> 'a -> 'a element

val insert_after : 'a element -> 'a -> 'a element
val remove : 'a t -> 'a element -> unit
