val a = 12;


fun beforeTime ((h1, m1, ap1: string),(h2, m2, ap2: string))=
    if ap1 < ap2 then true
    else if m1 < m2 then true
    else if h1 < h2 then true
    else false;

val b = beforeTime ((11, 59, "AM"), (1, 15, "PM"));

val henryV =
{   name = "Henry V",
    born = 1387,
    crowned = 1413,
    died = 1422,
    quote = "Bid them achieve me and then sell my bones"};

val richardIII = 
{   name ="Richard III",
    born = 1452,
    crowned =1483,
    died = 1485,
    quote ="Plots have I laid..."};

val {name=nameV , born=bornV , ...} = henryV ;
val {name,born,died ,quote,crowned } = richardIII ;


#quote richardIII;

#2 ("a", "g", 3, false);

type king = {name : string,
             born : int,
             crowned: int,
             died: int,
             quote: string};

fun lifetime({born, died, ...}:king) = died - born;
lifetime henryV;
lifetime richardIII;

fun born a t({born}) = born;