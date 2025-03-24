const std = @import("std");
const lib = @import("zigit_lib");
const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;

fn fibonacci(n: u16) u16 {
    if (n == 0 or n == 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

pub fn main() void {
    std.debug.print("Hello, {s}!\n", .{"World"});
}

test "use other module" {
    try expectEqual(@as(i32, 150), lib.add(100, 50));
}

test "value assignment" {
    const int_const = @as(i32, 50);
    var int_var: i32 = 50;
    int_var = int_var + int_const;
    try expectEqual(100, int_var);
}

test "type cast" {
    const len: u16 = 100;
    const int_len = @as(i32, @intCast(len));
    try expectEqual(@as(i32, 100), int_len);
}

test "array" {
    const array = [_]u8{ 't', 'e', 's', 't' };
    const len = array.len;
    try expectEqual(4, len);
}

test "if statement" {
    const a = true;
    var x: u16 = 0;
    if (a) {
        x += 1;
    } else {
        x += 2;
    }
    try expect(x == 1);
}

test "if statement expression" {
    const a = true;
    var x: u16 = 0;
    x += if (a) 1 else 2;
    try expect(x == 1);
}

test "for loop" {
    //character literals are equivalent to integer literals
    const string = [_]u8{ 'a', 'b' };

    for (string, 0..) |character, index| {
        if (index == 0) {
            try expect(character == 'a');
        } else {
            try expect(character == 'b');
        }
    }

    for (string) |character| {
        try expect(character == 'a');
        break;
    }

    for (string, 0..) |_, index| {
        try expect(string[index] == 'a');
        break;
    }
}

test "function recursion" {
    const x = fibonacci(10);
    try expect(x == 55);
}

test "defer" {
    // It is useful to ensure that resources are cleaned up when they are no longer needed.
    // Instead of needing to remember to manually free up the resource, you can add a defer statement right next to the statement that allocates the resource.
    var x: i16 = 5;
    {
        defer x += 2;
        try expect(x == 5);
    }
    try expect(x == 7);
}

test "coerce error from a subset to a superset" {
    const FileOpenError = error{
        AccessDenied,
        OutOfMemory,
        FileNotFound,
    };
    const AllocationError = error{OutOfMemory};

    const err: FileOpenError = AllocationError.OutOfMemory;
    try expect(err == FileOpenError.OutOfMemory);
}

test "error union" {
    const AllocationError = error{OutOfMemory};
    const maybe_error: AllocationError!u16 = 10;
    const no_error = maybe_error catch 0;

    try expect(@TypeOf(no_error) == u16);
    try expect(no_error == 10);
}

test "enum ordinal value" {
    const Value = enum(u2) { zero, one, two };
    try expect(@intFromEnum(Value.zero) == 0);
    try expect(@intFromEnum(Value.one) == 1);
    try expect(@intFromEnum(Value.two) == 2);
}

const Suit = enum {
    clubs,
    spades,
    diamonds,
    hearts,
    pub fn isClubs(self: Suit) bool {
        return self == Suit.clubs;
    }
};

test "enum method" {
    try expect(Suit.spades.isClubs() == Suit.isClubs(.spades));
}
