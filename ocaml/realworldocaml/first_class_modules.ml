open Base
open Stdio

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

module type Bumpable = sig
  type t

  val bump : t -> t
end

module Int_bumper = struct
  type t = int

  let bump n = n + 1
end

module Float_bumper = struct
  type t = float

  let bump n = n +. 1.
end

(* convert these to first-class modules: *)
let int_bumper = (module Int_bumper : Bumpable with type t = int)

let float_bumper = (module Float_bumper : Bumpable with type t = float)

let bump_list (type a) (module Bumper : Bumpable with type t = a) (l : a list) =
  List.map ~f:Bumper.bump l

module Unique = struct
  type config = int

  type t = { mutable next_id : int }

  let name = "unique"

  let create start_at = { next_id = start_at }

  let eval t sexp =
    match Or_error.try_with (fun () -> unit_of_sexp sexp) with
    | Error _ as err -> err
    | Ok () ->
        let response = Ok (Int.sexp_of_t t.next_id) in
        t.next_id <- t.next_id + 1;
        response
end

module M : sig
  type t
end = struct
  type t = string
end

let () =
  print_endline (Int.to_string New_three.x);
  let (module Bumper) = int_bumper in
  print_endline (Int.to_string (Bumper.bump 3))
