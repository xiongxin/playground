open Base

module type X_int = sig
  val x : int
end

module Three : X_int = struct
  let x = 3
end

(* to first-class module *)
let three = (module Three : X_int)

(* access the contents of a first-class module,
   you need to unpack it to an ordinary module *)
module New_three = (val three : X_int)

let to_int (module M : X_int) = M.x

module type Comparable = sig
  type t

  val compare : t -> t -> int
end

(** Here, what we effectively do is capture a 
    polymorphic type and export it as a concrete 
    type within a module. *)
let create_comparable (type a) compare =
  (module struct
    type t = a

    let compare = compare
  end : Comparable
    with type t = a)
