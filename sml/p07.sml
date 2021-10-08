infix mem;
fun (x mem []) = false
  | (x mem (y::l)) = (x=y) orelse (x mem l);

(* Graph algorithms *)

val graph1 = [("a","b"), ("a","c"), ("a","d"),
("b","e"), ("c","f"), ("d","e"),
("e","f"), ("e","g")];

fun nexts (a, []) = []
  | nexts (a, (x, y)::pairs) =
        if a=x then y::nexts(a, pairs) 
        else nexts (a,pairs);

nexts ("a", graph1);

fun depthf ([], graph, visited) = rev visited
  | depthf (x::xs, graph, visited) =
        if x mem visited then depthf (xs, graph, visited)
        else depthf (nexts (x, graph) @ xs, graph, x::visited);

depthf(["a"], graph1, []);

fun depth ([], graph, visited) = rev visited
  | depth (x::xs, graph, visited) =
        depth (xs, graph,
                if x mem visited then visited
                else depth(nexts(x, graph), graph, x::visited));


val grwork = [("wake","shower"),("dress","go"),
                ("eat","washup"),("shower","dress"),
                ("wake", "eat"),("washup","go")];

fun topsort graph =
    let fun sort ([], visited) = visited
          | sort (x::xs, visited) =
                sort(xs, if x mem visited then visited
                         else x :: sort(nexts (x, graph), visited))
        val (starts, _) = ListPair.unzip graph
    in
        sort(starts, [])
    end;

topsort(grwork);