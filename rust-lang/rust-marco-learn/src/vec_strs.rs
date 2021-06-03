macro_rules! vec_strs {
    (
        $(
            $element:expr
        ),*
    ) => {
        {
            let mut v = Vec::new();

            $(
                v.push(format!("{}", $element));
            )*

            v
        }
    }
}

#[test]
fn test_vec_strs() {
    let a = vec_strs!(1, 2, 3);

    assert_eq!(a.len(), 3);
}
