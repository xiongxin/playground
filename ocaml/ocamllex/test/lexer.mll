{ 
  open Lexing
}

rule translate = parse
  | "current_directory"	{ print_string (Sys.getcwd ()) }
  | _		{ print_int (let p = lexeme_start_p lexbuf in p.pos_lnum) }
  | eof			{ exit 0 }

{
  let main () =
    let lexbuf = Lexing.from_channel stdin in
    translate lexbuf

  let _ = Printexc.print main ()
}