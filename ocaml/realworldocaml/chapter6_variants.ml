open Base
open Stdio
module Time_ns = Core.Time_ns

module Log_entry = struct
  type t =
    { session_id : string
    ; time : Time_ns.t
    ; important : bool
    ; message : string
    }
end

module Heartbeat = struct
  type t =
    { session_id : string
    ; time : Time_ns.t
    ; status_message : string
    }
end

module Logon = struct
  type t =
    { session_id : string
    ; time : Time_ns.t
    ; user : string
    ; credentials : string
    }
end

type client_message =
  | Logon of Logon.t
  | Heartbeat of Heartbeat.t
  | Log_entry of Log_entry.t

let messages_for_user user messages =
  let user_messages, _ =
    List.fold
      messages
      ~init:([], Set.empty (module String))
      ~f:(fun ((messages, user_sessions) as acc) message ->
        match message with
        | Logon m ->
          if String.(m.user = user)
          then message :: messages, Set.add user_sessions m.session_id
          else acc
        | Heartbeat _ | Log_entry _ ->
          let session_id =
            match message with
            | Logon m -> m.session_id
            | Heartbeat m -> m.session_id
            | Log_entry m -> m.session_id
          in
          if Set.mem user_sessions session_id
          then message :: messages, user_sessions
          else acc)
  in
  List.rev user_messages
;;

type basic_color =
  | Black
  | Red
  | Green
  | Yellow
  | Blue
  | Magenta
  | Cyan
  | White

let basic_color_to_int = function
  | Black -> 0
  | Red -> 1
  | Green -> 2
  | Yellow -> 3
  | Blue -> 4
  | Magenta -> 5
  | Cyan -> 6
  | White -> 7
;;

type weight =
  | Regular
  | Bold

type color =
  | Basic of basic_color * weight (* basic colors, regular and bold *)
  | RGB of int * int * int (* 6x6x6 color cube *)
  | Gray of int
(* 24 grayscale levels *)

let color_by_number number text = Printf.sprintf "\027[38;5;%dm%s\027[0m" number text

let color_to_int = function
  | Basic (basic_color, weight) ->
    let base =
      match weight with
      | Bold -> 8
      | Regular -> 0
    in
    base + basic_color_to_int basic_color
  | RGB (r, g, b) -> 19 + b + (g * 6) + (r * 36)
  | Gray i -> 232 + i
;;

let color_print color s = printf "%s\n" (color_by_number (color_to_int color) s)
let blue = color_by_number (basic_color_to_int Blue) "Blue"

let () =
  print_endline (color_by_number 5 "Hello World");
  printf "Hello %s World!\n" blue;
  color_print (Basic (Red, Bold)) "A bold red!";
  color_print (Gray 4) "A muted gray..."
;;
