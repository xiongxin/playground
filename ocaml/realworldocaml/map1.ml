open Base

module Book = struct
  type t = { title : string; isbn : string }

  let compare t1 t2 =
    let cmp_title = String.compare t1.title t2.title in
    if cmp_title <> 0 then cmp_title else String.compare t1.isbn t2.isbn

  let sexp_of_t t : Sexp.t = List [ Atom t.title; Atom t.isbn ]
end
