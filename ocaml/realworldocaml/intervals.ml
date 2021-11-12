module type Comparable = sig
  type t

  val compare : t -> t -> int
end

module type Interval_intf = sig
  type t
  type endpoint

  val create : endpoint -> endpoint -> t
  val is_empty : t -> bool
  val contains : t -> endpoint -> bool
  val intersect : t -> t -> t
end

module Make_interval (Endpoint : Comparable) :
  Interval_intf with type endpoint = Endpoint.t = struct
  type endpoint = Endpoint.t

  type t =
    | Interval of endpoint * endpoint
    | Empty

  let create low high =
    if Endpoint.compare low high > 0 then Empty else Interval (low, high)
  ;;

  let is_empty = function
    | Empty -> true
    | Interval _ -> false
  ;;

  let contains t x =
    match t with
    | Empty -> false
    | Interval (low, high) -> Endpoint.compare x low >= 0 && Endpoint.compare x high <= 0
  ;;

  let intersect t1 t2 =
    let min x y = if Endpoint.compare x y <= 0 then x else y in
    let max x y = if Endpoint.compare x y >= 0 then x else y in
    match t1, t2 with
    | Empty, _ | _, Empty -> Empty
    | Interval (l1, h1), Interval (l2, h2) -> create (max l1 l2) (min h1 h2)
  ;;
end

module Int_interval = Make_interval (Int)

let () =
  let i1 = Int_interval.create 3 8 in
  let i2 = Int_interval.create 9 10 in
  let intersect = Int_interval.intersect i1 i2 in
  print_endline (Bool.to_string (Int_interval.is_empty intersect))
;;
