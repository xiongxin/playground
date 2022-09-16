open Batteries

let rec tribonacci signature n =
  match n, signature with
  | 1, a :: _ -> [ a ]
  | 2, a :: b :: _ -> [ a; b ]
  | 3, _ -> signature
  | n, [ a; b; c ] when n > 3 -> a :: tribonacci [ b; c; a + b + c ] (n - 1)
  | _, _ -> []
;;

let divisors n =
  let rec loop div n res =
    if n = 1
    then res
    else if div mod n = 0
    then loop div (n - 1) (n :: res)
    else loop div (n - 1) res
  in
  if n = 1 then [ 1 ] else if n = 2 then [ 1; 2 ] else loop n (n - 1) [ 1; n ]
;;

let () = print_endline "abc"
