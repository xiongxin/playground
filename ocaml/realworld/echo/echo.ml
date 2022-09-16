open Core
open Async

(** Copy data from the reader to the writer, using the provided buffer
   as scratch space *)
let rec copy_blocks buffer r w =
  match%bind Reader.read r buffer with
  | `Eof -> return ()
  | `Ok bytes_read ->
    Writer.write w (Bytes.to_string buffer) ~len:bytes_read;
    let%bind () = Writer.flushed w in
    copy_blocks buffer r w
;;

(** Starts a TCP server, which listens on the specified port, invoking
    copy_blocks every time a client connects. *)
let run () =
  let host_and_port =
    Tcp.Server.create
      ~on_handler_error:`Raise
      (Tcp.Where_to_listen.of_port 8765)
      (fun _addr r w ->
        let buffer = Bytes.create (16 * 1024) in
        copy_blocks buffer r w)
  in
  ignore (host_and_port : (Socket.Address.Inet.t, int) Tcp.Server.t Deferred.t)
;;

(** Call [run], and then start the scheduler *)
let () =
  run ();
  never_returns (Scheduler.go ())
;;

let alternate (n : int) (first_value : 'a) (second_value : 'a) : 'a list =
  let rec loop n i res =
    if n > 0
    then
      if i = 1
      then loop (n - 1) 2 (first_value :: res)
      else loop (n - 1) 1 (second_value :: res)
    else List.rev res
  in
  loop n 1 []
;;
