open Core

let rec read_and_accumulate accum =
  let line = In_channel.input_line In_channel.stdin in
  match line with
  | None -> accum
  | Some x -> read_and_accumulate (accum +. Float.of_string x)

let rec drop_value l to_drop =
  match l with
  | [] -> []
  | hd :: tl ->
      let new_tl = drop_value tl to_drop in
      if hd = to_drop then new_tl else hd :: new_tl

let max_widths header rows =
  let lengths l = List.map ~f:String.length l in
  List.fold rows ~init:(lengths header) ~f:(fun acc row ->
      List.map2_exn ~f:Int.max acc (lengths row))

let render_separator widths =
  let pieces = List.map widths ~f:(fun w -> String.make (w + 2) '-') in
  "|" ^ String.concat ~sep:"+" pieces ^ "|"

let pad s length = " " ^ s ^ String.make (length - String.length s + 1) ' '

let render_row row widths =
  let padded = List.map2_exn row widths ~f:pad in
  "|" ^ String.concat ~sep:"|" padded ^ "|"

let render_table header rows =
  let widths = max_widths header rows in
  String.concat ~sep:"\n"
    (render_row header widths :: render_separator widths
    :: List.map rows ~f:(fun row -> render_row row widths))

let extensions filenames =
  List.filter_map filenames ~f:(fun fname ->
      match String.rsplit2 ~on:'.' fname with
      | None | Some ("", _) -> None
      | Some (_, ext) -> Some ext)
  |> List.dedup_and_sort ~compare:String.compare

let is_ocaml_source s =
  match String.rsplit2 s ~on:'.' with
  | Some (_, ("ml" | "mli")) -> true
  | _ -> false

(* let () =
   List.iter
     (extensions [ "foo.c"; "foo.ml"; "bar.ml"; "bar.mli" ])
     ~f:print_endline *)

module Sys = Core.Sys
module Filename = Core.Filename

let rec ls_rec s =
  if Sys.is_file_exn ~follow_symlinks:true s then [ s ]
  else
    Sys.ls_dir s
    |> List.map ~f:(fun sub -> ls_rec (Filename.concat s sub))
    |> List.concat

let () =
  List.iter ~f:print_endline (ls_rec "/home/xiongxin/Data/Application/dbeaver")
