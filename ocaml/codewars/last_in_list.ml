(*
Write a function last that accepts a list and returns the last element in the list.

If the list is empty:

In languages that have a built-in option or result type (like OCaml or Haskell), return an empty option

In languages that do not have an empty option, just return null

module Tests = struct
    open OUnit
    let suite = [
        "last" >:::
            [
                "works correctly for non-empty lists" >:: (fun _ ->
                   assert_equal (last [1;2;3]) (Some 3)
                );
                "works correctly for empty lists" >:: (fun _ ->
                   assert_equal (last []) None
                )
            ]
        ]
    ;;
end
*)

open Stdio

let rec last xs =
  match xs with [] -> None | [ x ] -> Some x | _ :: tl -> last tl

let () =
  let l1 = [ 1; 2; 3 ] in
  match last l1 with Some i -> printf "%i\n" i | None -> print_endline "none"
