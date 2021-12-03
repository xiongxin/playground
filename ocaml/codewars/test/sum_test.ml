open Codewars
open OUnit2

let tests =
  "test suite for sum"
  >::: [ ("empty"
         >:: fun _ -> assert_bool "A start A" (Bookseller.string_index_is_start "A" 'A'))
       ; ("singleton"
         >:: fun _ ->
         assert_bool "Abc start A" (Bookseller.string_index_is_start "Abc" 'A'))
       ]
;;

let _ = run_test_tt_main tests
