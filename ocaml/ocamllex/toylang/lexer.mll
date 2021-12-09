(* header section *)
{
  open Printf
}


(* definitions section *)
let digit = ['0'-'9']
let id = ['a'-'z'] ['a'-'z' '0'-'9']*

(* rules section *)
rule toy_lang = parse
  | digit+ as inum { printf "integer: %s (%d)\n" inum (int_of_string inum); toy_lang lexbuf }
  | digit+ '.' digit* as fnum { printf "float: %s (%f)\n" fnum (float_of_string fnum); toy_lang lexbuf }
  | "if"
  | "then"
  | "begin"
  | "end"
  | "let"
  | "in"
  | "function" as word { printf "keyword: %s line=%d\n" word (let p = Lexing.lexeme_start_p lexbuf in p.pos_lnum); toy_lang lexbuf }
  | id as text { printf "identifier: %s\n" text; toy_lang lexbuf }
  | '+'
  | '-'
  | '*'
  | '/' as op { printf "operator: %c\n" op }
  | '{' [^ '\n']* '}' as comments { printf "comments: %s\n" comments; toy_lang lexbuf }  (* eat up one-line comments *)
  | [' ' '\t' '\n' ] { toy_lang lexbuf }   (* eat up whitespace *)
  | _ as c { printf "Unrecongized character: %c\n" c; toy_lang lexbuf }
  | eof { }

(* tailer section *)
{
  let main () =
    let cin = 
      if Array.length Sys.argv > 1
      then open_in Sys.argv.(1)
      else stdin
    in
    let lexbuf = Lexing.from_channel cin in
    toy_lang lexbuf

  let _ = Printexc.print main ()
}