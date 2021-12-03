open Base
open Stdio

let cmpute_bounds ~compare list =
  let open Option.Let_syntax in
  let sorted = List.sort ~compare list in
  let%bind first = List.hd sorted in
  let%bind last = List.last sorted in
  Some (first, last)

let cmpute_bounds2 ~compare list =
  let sorted = List.sort ~compare list in
  Option.both (List.hd sorted) (List.last sorted)

let merge_lists xs ys ~f =
  if List.length xs <> List.length ys then None
  else
    let rec loop xs ys =
      match (xs, ys) with
      | [], [] -> []
      | x :: xs, y :: ys -> f x y :: loop xs ys
      | _ -> assert false
    in
    Some (loop xs ys)

let parse_line line =
  String.split_on_chars ~on:[ ',' ] line |> List.map ~f:Float.of_string

let load filename =
  In_channel.with_file filename ~f:(fun inc ->
      In_channel.input_lines inc |> List.map ~f:parse_line)

exception Empty_list

let list_max = function
  | [] -> raise Empty_list
  | hd :: tl -> List.fold tl ~init:hd ~f:Int.max

let () =
  printf "%d\n" (list_max [ 1; 2; 3 ]);
  printf "%d\n" (list_max [])
