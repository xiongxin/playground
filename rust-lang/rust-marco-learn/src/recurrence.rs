macro_rules! recurrence {
    ( a[n] = $($inits:expr),+, ..., $recur:expr) => {
        /* */
    };
}

struct Recurrence {
    mem: [u64; 2],
    pos: usize,
}

impl Iterator for Recurrence {
    type Item = u64;

    fn next(&mut self) -> Option<Self::Item> {
        todo!()
    }
}
