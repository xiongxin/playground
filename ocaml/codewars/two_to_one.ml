(* 

Take 2 strings s1 and s2 including only letters from ato z.
Return a new sorted string, the longest possible, 
containing distinct letters - each taken only once - coming from s1 or s2.

a = "xyaabbbccccdefww"
b = "xxxxyyyyabklmopq"
longest(a, b) -> "abcdefklmopqwxy"

a = "abcdefghijklmnopqrstuvwxyz"
longest(a, a) -> "abcdefghijklmnopqrstuvwxyz" 
*)

open Base
open Stdio

let longest s1 s2 =
  let str = s1 ^ s2 in
  String.to_list str |> List.dedup_and_sort ~compare:Char.compare |> String.of_char_list
;;

let () = print_endline (longest "xyaabbbccccdefww" "xxxxyyyyabklmopq")
