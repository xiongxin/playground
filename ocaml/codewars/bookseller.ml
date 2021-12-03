let string_index_is_start s c =
  match String.index_opt s c with
  | Some a when a = 0 -> true
  | _ -> false
;;

let stock_list (lart : string array) (lcat : string array) =
  if Array.length lart = 0
  then ""
  else (
    let lart_assoc =
      List.map
        (fun x ->
          match String.split_on_char ' ' x with
          | hd :: hd' :: _ -> hd, int_of_string hd'
          | _ -> failwith "failwith stock_list")
        (Array.to_list lart)
    in
    let lcat_list = Array.to_list lcat in
    String.concat
      " - "
      (List.map
         (fun x ->
           let some_list =
             List.find_all
               (fun assoc -> string_index_is_start (fst assoc) x.[0])
               lart_assoc
           in
           let acc = List.fold_left (fun accu item -> accu + snd item) 0 some_list in
           "(" ^ x ^ " : " ^ string_of_int acc ^ ")")
         lcat_list))
;;

type 'a tree =
  | Leaf
  | Node of 'a * 'a tree * 'a tree

let () =
  let lart = [| "BBAR 150"; "CDXE 515"; "BKWR 250"; "BTSQ 890"; "DRTY 600" |] in
  let lcat = [| "A"; "B"; "C"; "D" |] in
  print_endline (stock_list lart lcat)
;;
