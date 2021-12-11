const std = @import("std");
const ArrayList = std.ArrayList;
const test_allocator = std.testing.allocator;
const expect = std.testing.expect;

test "fmt" {
    const string = try std.fmt.allocPrint(test_allocator, "{d} + {d} = {d}", .{ 9, 10, 19 });
    defer test_allocator.free(string);

    try expect(std.mem.eql(u8, string, "9 + 10 = 19"));
}

const Person = struct {
    name: []const u8,
    birth_year: i32,
    death_year: ?i32,
    pub fn format(self: Person, comptime fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
        _ = fmt;
        _ = options;

        try writer.print("{s} ({}-", .{ self.name, self.birth_year });

        if (self.death_year) |year| {
            try writer.print("{}", .{year});
        }

        try writer.writeAll(")");
    }
};

test "costom fmt" {
    const john = Person{ .name = "John Carmack", .birth_year = 1970, .death_year = null };

    const john_string = try std.fmt.allocPrint(test_allocator, "{s}", .{john});
    defer test_allocator.free(john_string);

    try expect(std.mem.eql(u8, john_string, "John Carmack (1970-)"));

    const claude = Person{ .name = "Claude Shannon", .birth_year = 1916, .death_year = 2001 };
    const claude_string = try std.fmt.allocPrint(
        test_allocator,
        "{s}",
        .{claude},
    );
    defer test_allocator.free(claude_string);

    try expect(std.mem.eql(
        u8,
        claude_string,
        "Claude Shannon (1916-2001)",
    ));
}
