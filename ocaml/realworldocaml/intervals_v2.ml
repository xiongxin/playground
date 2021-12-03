open Base
open Stdio

module type Comparable = sig
  type t

  val compare : t -> t -> int
end

module type Interval_intf = sig
  type t
  (** 代表 间隔类型 *)

  type endpoint
  (** 代表 endpoint类型 *)

  val create : endpoint -> endpoint -> t

  val is_empty : t -> bool

  val contains : t -> endpoint -> bool

  val intersect : t -> t -> t
end

(** 直接返回struct是会将 type t暴露给外界直接使用
    必须使用sig来抽象struct，将 type t 抽象起来
    <Module_type> with type <type> = <type'> *)
module Make_interval (Endpoint : sig
  type t

  include Comparable with type t := t

  include Core.Sexpable with type t := t
end) : Interval_intf with type endpoint := Endpoint.t = struct
  type t = Interval of Endpoint.t * Endpoint.t | Empty [@@deriving sexp]

  (** [create low high] creates a new interval from [low] to [high].
      if[low > high], then the interval is empty *)
  let create low high =
    if Endpoint.compare low high > 0 then Empty else Interval (low, high)

  (** Return true iff the interval is empty *)
  let is_empty = function Empty -> true | Interval _ -> false

  (** [contains t x ]return true iff [x] is contained in the interval [t] *)
  let contains t x =
    match t with
    | Empty -> false
    | Interval (l, h) -> Endpoint.compare x l >= 0 && Endpoint.compare x h <= 0

  (** [intersect t1 t2] return the intersection of the two input intervals *)
  let intersect t1 t2 =
    let min x y = if Endpoint.compare x y <= 0 then x else y in
    let max x y = if Endpoint.compare x y >= 0 then x else y in
    match (t1, t2) with
    | Empty, _ | _, Empty -> Empty
    | Interval (l1, h1), Interval (l2, h2) -> create (max l1 l2) (min h1 h2)
end

let () = printf "ok\n"
