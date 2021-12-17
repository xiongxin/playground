%{
  open Ast

(** [make_apply e [e1; e2; ...]] make the application
    [e e1 e2 ...], Requires: the list argument is non-empty. *)
let rec make_apply e = function
  | [] -> failwith "precondition violated"
  | [e'] -> App (e, e')
  | h :: ((_ :: _) as t) -> make_apply (App (e, h)) t
%}

%token <string> ID
%token FUN ARROW LPAREN RPAREN EOF

%start <Ast.expr> prog

%%

prog:
  | e = expr; EOF { e }
  ;

expr:
  | e = simpl_expr { e }
  | e = simpl_expr; es = simpl_expr+ { make_apply e es }
  | FUN; x = ID; ARROW; e = expr { Fun (x, e) }
  ;

simpl_expr:
  | x = ID { Var x }
  | LPAREN; e = expr; RPAREN { e }
  ;