const std = @import("std");
const testing = std.testing;

pub fn main() !void {
    std.debug.print("Hello, World!\n", .{});
}

test "testing a test" {
    try testing.expect(1 == 1);
}
