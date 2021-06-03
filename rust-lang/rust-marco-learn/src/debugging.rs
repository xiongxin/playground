macro_rules! each_tt {
    () => {

    };
    ($tt:tt $($rest:tt)*) => {
        log_syntax!($tt);
        each_tt!($($rest)*);
    }
}

// #[test]
// fn test_each_tt() {
//     //each_tt!(foo bar baz quux);
//     trace_macros!(true);
//     each_tt!(spim wak plee whum);
//     trace_macros!(false);
//     // each_tt!(trom qlip winp xod);
// }
