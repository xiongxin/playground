open Base
open Stdio

let () =
  let d = Dictionary.create ~hash:String.hash ~equal:String.equal in
  Dictionary.add d ~key:"aaa1" ~data:"b1";
  Dictionary.add d ~key:"aaa2" ~data:"b2";
  Dictionary.add d ~key:"aaa3" ~data:"b3";
  printf "%d\n" (Dictionary.length d);
  Dictionary.iter d ~f:(fun ~key ~data ->
      print_endline key;
      print_endline data)
;;
