{ }

rule translate = parse
  | "current_directory"	{ print_string (Sys.getcwd ()) }
  | _ as c		{ print_char c }
  | eof			{ exit 0 }

{
  let main () =
    let lexbuf = Lexing.from_channel stdin in
    translate lexbuf

  let _ = Printexc.print main ()
}