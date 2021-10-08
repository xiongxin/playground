(* mutually recursive *)
fun pos d = neg(d-2.0) + 1.0/d
and neg d = if d > 0.0 then pos(d-2.0) - 1.0/d
                        else 0.0;

4.0 * pos(201.0);

fun F(x, y, z) = G(x+1, y, z)
and G(x, y, z) = if y < z then F(x,y,z) else H(x, x+y,z)
and H(x, y, z) = if z > 0 then F(x,y,z-x) else (x, y, z);


F(0, 0, 0);

structure Complex = 
    struct
    type t = real * real;
    val zero = (0.0, 0.0)
    fun sum ((x, y), (x', y')) = (x+x', y+y'):t;
    fun diff ((x,y), (x', y')) = (x-x', y-y'):t;
    fun prod ((x, y), (x',y')) = (x*x'-y*y', x*y' + x'*y) : t;
    fun recip (x, y) = let val t = x*x + y*y in (x/t, ~y/t) end
    fun quo (z, z') = prod(z, recip z');
    end;

val i = (0.0, 1.0);
val a = (0.3, 0.0);
val b= Complex.sum(a, i);
Complex.sum(b, (0.7, 0.0));
Complex.prod(it, it);

signature ARITH = 
    sig
    type t
    val zero : t
    val sum : t * t -> t
    val diff : t * t -> t
    val prod : t * t -> t
    val quo : t *t -> t
    end;

structure Real : ARITH =
    struct
    type t = real;
    val zero = 0.0;
    fun sum (a, b) = a + b : t;
    fun diff (a, b) = a - b : t;
    fun prod (a, b) =  a * b : t;
    fun quo (a, b) = a / b: t;
    end;

fun f(k, m) = if k = 0 then 1 else f(k,1);


fun pairself x = (x, x);
fun fst (x, y) = x;
fun snd (x, y) = y;
fun fstfst z = fst(fst z);
val pp = pairself("Help!", 999);
fstfst pp;