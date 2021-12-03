open OUnit2
open Sum

let make_sume_test name expected_output input =
  name >:: fun _ -> assert_equal expected_output (sum input) ~printer:string_of_int
;;

let tests =
  "test suite for sum"
  >::: [ make_sume_test "empty" 0 []
       ; make_sume_test "singleton" 1 [ 1 ]
       ; make_sume_test "two_elements" 3 [ 1; 2 ]
       ]
;;

let _ = run_test_tt_main tests
