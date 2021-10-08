(* Application of Lists *)

fun change (coninvals, 0) = []
  | change (c::coninvals, amount) =
        if amount < c then change (coninvals, amount)
        else c :: change (c::coninvals, amount -c );


val gbconis = [50, 20, 10, 5, 2, 1]
and usconis = [25, 10, 5, 1];

change(gbconis, 43);
change(usconis, 43);
(* change([5, 2], 16); Bad! *)

fun allChange (coins, coinvals, 0) = [coins]
  | allChange (coins, [], amount)  = []
  | allChange (coins, c::coinvals, amount) =
        if amount < 0 then []
        else allChange(c::coins, c::coinvals, amount - c)
            @ allChange (coins, coinvals, amount);

allChange([], [2,5], 16);
allChange([], [5,2], 16);

fun bincarry (0, ps) = ps
  | bincarry (1, []) = [1]
  | bincarry (1, p::ps) = (1-p) :: bincarry(p, ps);


fun binsum (c, [], qs) = bincarry (c, qs)
  | binsum (c, ps, []) = bincarry (c, ps)
  | binsum (c, p::ps, q::qs) =
    ((c + p + q) mod 2) :: binsum((c+p+q) div 2, ps, qs);

binsum(0, [1,1,0,1], [0,1,1,1,1]);

(* 
In ML , an equality type variable begins with two ’ characters.
*)

infix mem;
fun (x mem []) = false
  | (x mem (y::l)) = (x=y) orelse (x mem l);

"Sally" mem ["Regan","Goneril","Cordelia"];

fun newmem(x, xs) = if x mem xs then xs else x::xs;

(* 集合操作 *)

fun setof [] = []
  | setof (x::xs) = newmem(x, setof xs);

setof [true, false, false, true, false];

fun union ([], ys) = ys
  | union (x::xs, ys) = newmem(x, union(xs, ys));

union([1,2,3], [0,2,4]);

fun inter ([], ys) = []
  | inter (x::xs, ys) = if x mem ys then x::inter(xs, ys)
                        else inter (xs, ys);

inter (["John","James","Mark"], ["Nebuchadnezzar","Bede"]);

(* Set T is a subset of S if all elements of T are also elements of S*)
infix subs;
fun ([] subs ys) = true
  | ((x::xs) subs ys) = (x mem ys) andalso (xs subs ys);

[("May",5), ("June",6)] subs [("July",7)];
[("May",5), ("June",6)] subs [("July",7),("May",5), ("June",6)];

infix seq;
fun (xs seq ys) = (xs subs ys) andalso (ys subs xs);
[3,1,3,5,3,4] seq [1,3,4,5];


(* powset(S , B ) = {T ∪ B | T ⊆ S } *)
fun powset ([], base) = [base]
  | powset (x::xs, base) =
        powset(xs, base) @ powset(xs, x::base);

powset([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], []);
powset (rev ["the","weird","sisters"], []);

fun cartprod ([], ys) = []
  | cartprod (x::xs, ys) =
        let val xsprod = cartprod(xs, ys)
            fun pairx [] = xsprod
              | pairx (y::ytail) = (x, y) :: (pairx ytail)
        in pairx ys 
        end;

cartprod ([2,5], ["moons","stars","planets"]);


fun assoc ([], a) = []
  | assoc ((x,y)::pairs, a) = if a=x then [y]
                              else assoc(pairs, a);

val battles =
[("Crecy",1346), ("Poitiers",1356), ("Agincourt",1415),
("Trafalgar",1805), ("Waterloo",1815)];
assoc(battles, "Agincourt");