open Base
open Stdio

let compute_bounds ~compare list =
  let sorted = List.sort list ~compare in
  match List.hd sorted, List.last sorted with
  | Some x, Some y -> Some (x, y)
  | _ -> None
;;

let () = print_endline "error handling"
