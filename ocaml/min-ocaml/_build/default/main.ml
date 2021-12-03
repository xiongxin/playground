let limit = ref 1000

let () =
  let files = ref [] in
  Arg.parse
    [
      ( "-inline",
        Arg.Int (fun i -> Inline.threshold := i),
        "maximum size of functions inlined" );
      ( "-iter",
        Arg.Int (fun i -> limit := i),
        "maximum number of optimizations iterated" );
    ]
    (fun s -> files := !files @ [ s ])
    ("Mitou Min-Caml Compiler (C) Eijiro Sumii\n"
    ^ Printf.sprintf
        "usage: %s [-inline m] [-iter n] ...filenames without \".ml\"..."
        Sys.argv.(0));
  Printf.printf "%d\n" (!Inline.threshold + 100)
