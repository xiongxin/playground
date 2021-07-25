fun fact n =
    if n = 0 then 1 else n * fact(n-1);

fact 7;
(* fact 35; *)

(*

fact(4) ⇒ 4 × fact(4 − 1)
⇒ 4 × fact(3)
⇒ 4 × (3 × fact(3 − 1))
⇒ 4 × (3 × fact(2))
⇒ 4 × (3 × (2 × fact(2 − 1)))
⇒ 4 × (3 × (2 × fact(1)))
⇒ 4 × (3 × (2 × (1 × fact(1 − 1))))
⇒ 4 × (3 × (2 × (1 × fact(0))))
⇒ 4 × (3 × (2 × (1 × 1)))
⇒ 4 × (3 × (2 × 1))
⇒ 4 × (3 × 2)
⇒ 4 × 6
⇒ 24

*)

fun facti (n, p) =
    if n = 0 then p else facti(n - 1, n * p);

facti(10, 1);

fun cond(p, x, y): int =
    if p then x else y;

(* the recursion cannot terminate *)
fun badf n = cond(n = 0, 1, n * badf(n-1));

fun even n = (n mod 2 = 0);
fun powoftwo n = (n=1) orelse
                 (even(n) andalso powoftwo(n div 2));

(*
powoftwo(6) ⇒ (6 = 1) orelse (even(6) andalso · · · )
⇒ even(6) andalso powoftwo(6 div 2)
⇒ powoftwo(3)
⇒ (3 = 1) orelse (even(3) andalso · · · )
⇒ even(3) andalso powoftwo(3 div 2)
⇒ false

powoftwo(8) ⇒ (8 = 1) orelse (even(8) andalso · · · )
⇒ even(8) andalso powoftwo(8 div 2)
⇒ powoftwo(4)
⇒ (4 = 1) orelse (even(4) andalso · · · )
⇒ even(4) andalso powoftwo(4 div 2)
⇒ powoftwo(2)
=>(2 = 1) orelse (even(2) andalso ...)
=>even(2) andslo powoftwo(2 div 2)
=>true
*)
fun sqr x = x * x;
fun zero (x:int) = 0;

sqr(sqr(sqr(2)));
sqr(2)*sqr(2)*sqr(2)*sqr(2);

fun power(x, k) : real =
    if k = 1 then x
    else if k mod 2 = 0 then power(x * x, k div 2)
    else x * power(x * x, k div 2);
(*
Write the computation steps for power (2.0, 29).

power(2.0, 29)
=> 2.0 * power(4.0, 14)
=> 2.0 * power(16.0, 7)
=> 2.0 * 16.0 * power(256.0, 3)
=> 2.0 * 16.0 * 256.0 * power(65536.0, 1)
=> 2.0 * 16.0 * 256.0 * 65536.0
*)

fun nextfib(prev, curr: int) = (curr, prev + curr);
fun fibpair n =
    if  n=1 then (0, 1) else nextfib(fibpair(n-1));


(* fibpair(30) =nextfib(nextfib(...nextfib(0,1)...)) *)
fibpair 30;

fun itfib(n, prev, curr):int =
    if n = 1 then curr
    else itfib(n - 1, curr, prev + curr);

fun fib n = itfib(n, 0, 1);

fib 30;

(* 求k平方最接近n的值 *)
fun increase (k, n)=
    if (k+1) * (k+1) > n then k
    else k + 1;

(*  *)
fun introot n=
    if n=0 then 0 
    else increase(2 * introot(n div 4), n);

(* 
introot(17)
= increase(2 * introot(4), 17)
= increase(2 * increase(2 * introot(1), 4), 17)
= increase(2 * increase(2 * increase(2 * introot(0), 1), 4), 17)
= increase(2 * increase(2 * increase(2 * 0, 1), 4), 17)
= increase(2 * increase(2 * increase(0, 1), 4), 17)
= increase(2 * increase(2 * 1, 4), 17)
= increase(2 * increase(2, 4), 17)
= increase(2 * 2, 17)
= increase(4, 17)
= 4
*)
introot 800;

fun findroot (a, x, acc) =
    let val nextx = (a / x + x) / 2.0
    in if abs(x - nextx) < acc * x
        then nextx else findroot (a, nextx, acc)
    end;

fun sqroot a = findroot(a, 1.0, 10E~10);

sqroot 2.0;