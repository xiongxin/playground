open Core_kernel
open Stdio

type service_info =
  { service_name : string
  ; port : int
  ; protocol : string
  ; comment : string option
  }

type 'a with_line_num =
  { item : 'a
  ; line_num : int
  }

let service_info_of_string line =
  let line, comment =
    match String.rsplit2 line ~on:'#' with
    | None -> line, None
    | Some (ordinary, comment) -> ordinary, Some comment
  in
  let matches =
    let pat = "([a-zA-Z]+)[ \t]+([0-9]+)/([a-zA-Z]+)" in
    Re.exec (Re.Posix.compile_pat pat) line
  in
  { service_name = Re.Group.get matches 1
  ; port = Int.of_string (Re.Group.get matches 2)
  ; protocol = Re.Group.get matches 3
  ; comment
  }
;;

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
  [@@deriving fields]
end

type client_info =
  { addr : Core.Unix.Inet_addr.t
  ; port : int
  ; user : string
  ; credentials : string
  ; mutable last_heartbeat_time : Time_ns.t
  ; mutable last_heartbeat_status : string
  }

let register_heartbeat t hb =
  t.last_heartbeat_time <- hb.Heartbeat.time;
  t.last_heartbeat_status <- hb.Heartbeat.status_message
;;

let parse_lines parse file_contents =
  let lines = String.split ~on:'\n' file_contents in
  List.mapi lines ~f:(fun line_num line -> { item = parse line; line_num = line_num + 1 })
;;

let service_info_to_string { service_name; port; protocol; comment } =
  let base = sprintf "%s %i %s" service_name port protocol in
  match comment with
  | None -> base
  | Some text -> base ^ " #" ^ text
;;

let create_log_entry ~session_id ~important message : Log_entry.t =
  { Log_entry.time = Time_ns.now ()
  ; Log_entry.session_id
  ; Log_entry.important
  ; Log_entry.message
  }
;;

let get_users logons =
  List.dedup_and_sort ~compare:String.compare (List.map logons ~f:Logon.user)
;;

let message_to_string { Log_entry.important; message; _ } =
  if important then String.uppercase message else message
;;

let is_important t = t.Log_entry.important

let () =
  let lines =
    parse_lines
      service_info_of_string
      "rtmp              1/ddp     # Routing Table Maintenance Protocol\n\
      \       tcpmux            1/udp     # TCP Port Service Multiplexer\n\
      \       tcpmux            1/tcp     # TCP Port Service Multiplexer"
  in
  let ssh = service_info_of_string "ssh 22/udp # SSH Remote Login Protocol" in
  let log_entry = create_log_entry ~session_id:"abc" ~important:true "aaa message" in
  printf "%i %i\n" ssh.port (List.length lines);
  List.map lines ~f:(fun x -> x.item)
  |> List.map ~f:service_info_to_string
  |> List.iter ~f:print_endline;
  printf "%s" log_entry.message
;;
