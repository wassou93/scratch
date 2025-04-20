const std = @import("std");
const testing = std.testing;

pub fn main() !void {
    const string = [_]u8{ 'a', 'b', 'c' };

    for (string) |character| {
        std.debug.print("{u}", .{character});
    }
}

test "testing a test" {
    try testing.expect(1 == 1);
}
