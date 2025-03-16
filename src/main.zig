const std = @import("std");
const lib = @import("zigit_lib");

pub fn main() void {
    std.debug.print("Hello, {s}!\n", .{"World"});
}

test "use other module" {
    const int_const = @as(i32, 50);
    var int_var = @as(i32, 50);
    int_var = int_var + int_const;
    try std.testing.expectEqual(@as(i32, 150), lib.add(int_const, int_var));
}
