const std = @import("std");
const lib = @import("zigit_lib");

pub fn main() void {
    std.debug.print("Hello, {s}!\n", .{"World"});
}

test "use other module" {
    const int_const = @as(i32, 50);
    var int_var = @as(i32, 45);
    int_var = int_var + int_const;

    const array = [_]u8{ 'h', 'e', 'l', 'l', 'o' };
    const len = array.len; // 5
    const int_len = @as(i32, @intCast(len));
    int_var = int_var + int_len;

    try std.testing.expectEqual(@as(i32, 150), lib.add(int_const, int_var));
}
