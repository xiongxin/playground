const std = @import("std");

const inferred_constant = @as(i32, 5);

pub fn main() void {
    std.debug.print("Hi, {s}!\n", .{"Zig"});
}
