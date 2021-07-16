const std = @import("std");

pub fn main() anyerror!void {
    std.log.info("All your codebase are belong to us.", .{});

    var array = "hello".*;
    const ptr = &array;
    std.log.info("Array {}", .{ptr[0]});

    var buf: [5]u8 = "hello".*;
    var x: [*]u8 = &buf;
    x += 1;
    std.testing.expect(x == 'e');
}
