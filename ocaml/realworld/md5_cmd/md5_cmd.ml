open Core

let checksum_from_string buf = Md5.digest_string buf |> Md5.to_hex |> print_endline

let checksum_from_file filename =
  let contents =
    match filename with
    | "-" -> In_channel.input_all In_channel.stdin
    | filename -> In_channel.read_all filename
  in
  Md5.digest_string contents |> Md5.to_hex |> print_endline
;;

let command =
  Command.basic
    ~summary:"Generate an MD5 hash of the input data"
    ~readme:(fun () -> "More detailed information")
    (let%map_open.Command use_string =
       flag "-s" (optional string) ~doc:"String check sum the given string"
     and trial = flag "-t" no_arg ~doc:" run a built-in time trial"
     and filename =
       anon (maybe_with_default "-" ("filename" %: Filename_unix.arg_type))
     in
     fun () ->
       if trial
       then printf "Running time trial\n"
       else (
         match use_string with
         | Some buf -> checksum_from_string buf
         | None -> checksum_from_file filename))
;;

let () = Command_unix.run ~version:"1.0" ~build_info:"RWO" command
