open Core_kernel
open Stdio

module type Query_handler = sig
  type config
  (** Configuration for a query handler *)

  val sexp_of_config : config -> Sexp.t

  val config_of_sexp : Sexp.t -> config

  val name : string
  (** The name of the query-handling service *)

  type t
  (** The state of the query handler *)

  val create : config -> t
  (** creates a new query handler from a config *)

  val eval : t -> Sexp.t -> Sexp.t Or_error.t
  (** Evaluate a given query, where both input and output are s-expressions *)
end

module Unique = struct
  type config = int [@@deriving sexp]

  type t = { mutable next_id : int }

  let name = "unique"

  let create start_at = { next_id = start_at }

  let eval t sexp =
    match Or_error.try_with (fun () -> unit_of_sexp sexp) with
    | Error _ as err -> err
    | Ok () ->
        let response = Ok (Int.sexp_of_t t.next_id) in
        t.next_id <- t.next_id + 1;
        response
end

module List_dir = struct
  type config = string [@@deriving sexp]

  type t = { cwd : string }

  (** [is_abs p] Returns true if [p] is an absolute path *)
  let is_abs p = String.length p > 0 && Char.( = ) p.[0] '/'

  let name = "ls"

  let create cwd = { cwd }

  let eval t sexp =
    match Or_error.try_with (fun () -> string_of_sexp sexp) with
    | Error _ as err -> err
    | Ok dir ->
        let dir = if is_abs dir then dir else Core.Filename.concat t.cwd dir in
        Ok (Array.sexp_of_t String.sexp_of_t (Core.Sys.readdir dir))
end

module type Query_handler_instance = sig
  module Query_handler : Query_handler

  val this : Query_handler.t
end

module Loader = struct
  type config = ((module Query_handler) list[@sexp.opaque]) [@@deriving sexp]

  type t = {
    know : (module Query_handler) String.Table.t;
    active : (module Query_handler_instance) String.Table.t;
  }

  let name = "loader"
end

let build_instance (type a) (module Q : Query_handler with type config = a)
    config =
  (module struct
    module Query_handler = Q

    let this = Q.create config
  end : Query_handler_instance)

let build_dispatch_table handlers =
  let table = Hashtbl.create (module String) in
  List.iter handlers
    ~f:(fun ((module I : Query_handler_instance) as instance) ->
      Hashtbl.set table ~key:I.Query_handler.name ~data:instance);
  table

let dispatch dispatch_table name_and_query =
  match name_and_query with
  | Sexp.List [ Sexp.Atom name; query ] -> (
      match Hashtbl.find dispatch_table name with
      | None ->
          Or_error.error "Could not find matching handler" name String.sexp_of_t
      | Some (module I : Query_handler_instance) ->
          I.Query_handler.eval I.this query)
  | _ -> Or_error.error_string "malformed query"

let rec cli dispatch_table =
  printf ">>> %!";
  let result =
    match In_channel.(input_line stdin) with
    | None -> `Stop
    | Some line -> (
        match Or_error.try_with (fun () -> Core.Sexp.of_string line) with
        | Error e -> `Continue (Error.to_string_hum e)
        | Ok (Sexp.Atom "quit") -> `Stop
        | Ok query -> (
            match dispatch dispatch_table query with
            | Error e -> `Continue (Error.to_string_hum e)
            | Ok s -> `Continue (Sexp.to_string_hum s)))
  in
  match result with
  | `Stop -> ()
  | `Continue msg ->
      printf "%s\n%!" msg;
      cli dispatch_table

let unique_instance = build_instance (module Unique) 0

let list_dir_instance = build_instance (module List_dir) "/home/xiongxin"

let () = cli (build_dispatch_table [ unique_instance; list_dir_instance ])
