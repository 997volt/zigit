const std = @import("std");
const lib = @import("zigit_lib");

fn fibonacci(n: u16) u16 {
    if (n == 0 or n == 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

pub fn main() void {
    std.debug.print("Hello, {s}!\n", .{"World"});
}

test "use other module" {
    try std.testing.expectEqual(@as(i32, 150), lib.add(100, 50));
}

test "value assignment" {
    const int_const = @as(i32, 50);
    var int_var: i32 = 50;
    int_var = int_var + int_const;
    try std.testing.expectEqual(100, int_var);
}

test "type cast" {
    const len: u16 = 100;
    const int_len = @as(i32, @intCast(len));
    try std.testing.expectEqual(@as(i32, 100), int_len);
}

test "array" {
    const array = [_]u8{ 't', 'e', 's', 't' };
    const len = array.len;
    try std.testing.expectEqual(4, len);
}

test "if statement" {
    const a = true;
    var x: u16 = 0;
    if (a) {
        x += 1;
    } else {
        x += 2;
    }
    try std.testing.expect(x == 1);
}

test "if statement expression" {
    const a = true;
    var x: u16 = 0;
    x += if (a) 1 else 2;
    try std.testing.expect(x == 1);
}

test "for loop" {
    //character literals are equivalent to integer literals
    const string = [_]u8{ 'a', 'b' };

    for (string, 0..) |character, index| {
        if (index == 0) {
            try std.testing.expect(character == 'a');
        } else {
            try std.testing.expect(character == 'b');
        }
    }

    for (string) |character| {
        try std.testing.expect(character == 'a');
        break;
    }

    for (string, 0..) |_, index| {
        try std.testing.expect(string[index] == 'a');
        break;
    }
}

test "function recursion" {
    const x = fibonacci(10);
    try std.testing.expect(x == 55);
}
