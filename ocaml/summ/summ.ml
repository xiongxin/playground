open Base
open Stdio

let rec read_and_accumulate accum =
  let line = In_channel.input_line In_channel.stdin in
  match line with
  | None -> accum
  | Some x -> read_and_accumulate (accum +. Float.of_string x)
;;

let () =
  let ratio x y =
    let open Float.O in
    of_int x / of_int y
  in
  printf "Total: %F\n" (ratio 1 2)
;;
