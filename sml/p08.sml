datatype person = King
                | Peer of string*string*int
                | Knight of string
                | Peasant of string;

val persons = [King, Peasant "Jack Cade", Knight "Gawain"];



fun title King = "His Majesty the King"
  | title (Peer (deg,terr ,_)) = "The " ^ deg ^ " of " ^ terr
  | title (Knight name) = "Sir " ^ name
  | title (Peasant name) = name;

title(King);

fun sirs [] = []
  | sirs ((Knight s) :: ps) = s :: (sirs ps)
  | sirs (p :: ps) = sirs ps;

sirs(persons);

fun toint King = 4
  | toint (Peer _) = 3
  | toint (Knight _) = 2
  | toint (Peasant _) = 1;

fun superior (a, b) =
    if (toint(a) > toint(b)) then true
    else false;

(* enummeration types *)

datatype degree = Duke | Marquis | Earl | Viscount | Baron;

datatype person = King
                | Peer of degree*string*int
                | Knight of string
                | Peasant of string;

fun lady Duke = "Duchess"
    | lady Marquis = "Marchioness"
    | lady Earl = "Countess"
    | lady Viscount = "Viscountess"
    | lady Baron = "Baroness";

