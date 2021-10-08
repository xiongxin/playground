(* Lists *)

fun upto(m, n) =
    if m > n then [] else m :: upto(m + 1, n);

upto(2, 5);


fun prod [] = 1
  | prod (n::ns) = n * (prod ns);

prod [2,3, 5];

fun maxl [m] : int = m
  | maxl (m::n::ns) = if m > n then maxl(m::ns)
                               else maxl(n::ns);


fun prod ns = if null ns then 1
                         else (hd ns) * (prod (tl ns));
prod [2,3, 5, 1, 2, 3, 4, 5];

(* Exercise 3.1
matching.
Write a version of maxl using null , hd and tl , instead of pattern- *)
fun maxl ns : int = 
    if List.length(ns) = 1 then hd ns
    else if (hd ns) > (hd (tl ns)) then 
        maxl((hd ns)::(tl (tl ns)))
    else maxl(tl ns);

maxl [2,3, 5, 1];


(* Exercise 3.2 Write a function to return the last element of a list. *)
fun lastl(ns) =
    if List.length(ns) = 1 then hd ns
    else lastl(tl ns);

lastl([2,3, 5, 1, 2, 3, 4, 5,100]);


(* 利用尾递归，节省内存空间 *)
local
  fun addlen (n, []) = n
    | addlen (n, x::l) = addlen (n + 1, l)
in
  fun length l = addlen (0, l)
end;

length(upto(1, 1000000));

fun take ([], i) = []
  | take (x::xs, i) = if i > 0 then x::take(xs, i - 1)
                               else [];
take(explode "abcdef", 3);

fun rtake ([], _, taken) = taken
  | rtake (x::xs, i, taken) =
        if i > 0 then rtake(xs, i -1, x::taken)
                 else taken;

rtake(explode "Throw physic to the dogs!", 5, []);

fun drop ([], _) = []
  | drop (x::xs, i) =
        if i > 0 then drop(xs, i - 1)
                 else x::xs;
drop (["Never","shall","sun","that","morrow","see!"], 3);

(* Exercise 3.3 What do take(l ,i ) and drop(l ,i ) return when i > length(l ),
and when i < 0? (The library versions of take and drop would raise excep-
tions.)
take(l, i) i > length(l),返回length(l)的列表
drop(l, i) i > length(l),返回[]
*)

(* 
Exercise 3.4 Write a function nth(l ,n) to return the nth element of l (where
the head is element 0).
*)
fun nth ([m], _) = m
  | nth (x::xs, i) =
        if i > 0 then nth(xs, i - 1)
                 else x;

nth(explode("abcdefg"), 2);

["Why", "sinks"] @ ["that", "cauldron?"];

fun nrev [] = []
  | nrev (x::xs) = (nrev xs) @ [x];

nrev (["Why", "sinks"] @ ["that", "cauldron?"]);

fun revAppend ([], ys) = ys
  | revAppend (x::xs, ys) = revAppend(xs, x::ys);

revAppend (["Why", "sinks"] @ ["that", "cauldron?"], []);

fun rev xs = revAppend(xs, []);

fun concat [] = []
  | concat (l::ls) = l @ concat ls;

concat [["When","shall"], ["we","three"], ["meet","again"]];


fun zip(x::xs, y::ys) = (x, y) :: zip(xs, ys)
  | zip _ = [];
zip (["Why", "sinks"], ["that", "cauldron?"])

fun conspair ((x, y), (xs, ys)) = (x::xs, y::ys);

fun unzip [] = ([], [])
  | unzip (pair::pairs) = conspair(pair, unzip pairs);

unzip([("Why","that"),("sinks","cauldron?")]);

fun unzip [] = ([], [])
  | unzip((x, y)::pairs) =
        let val (xs, ys) = unzip pairs
        in (x::xs, y::ys) end;

unzip([("Why","that"),("sinks","cauldron?")]);

fun revUnzip ([], xs, ys) = (xs, ys)
  | revUnzip ((x, y)::pairs, xs, ys) =
        revUnzip(pairs, x::xs, y::ys);

revUnzip([("Why","that"),("sinks","cauldron?")], [], []);

