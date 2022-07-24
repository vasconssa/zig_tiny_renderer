const std = @import("std");

//pub const vec2_t = packed union {
//v: packed struct { x: f32, y: f32 },
//f: [2]f32,
//};

pub const vec2_t = extern struct {
    x: f32,
    y: f32,
};

pub const rgba_t = extern struct {
    r: u8,
    g: u8,
    b: u8,
    a: u8,
};

test "Test vec2_t type layout" {
    //var p = vec2_t{ .v = .{ .x = 1.0, .y = 2.0 } };
    //std.debug.print("p.x: {}, p.y: {}\n", .{ p.v.x, p.v.y });
    //std.debug.print("p.x: {}, p.y: {}\n", .{ p.f[0], p.f[1] });

    var p = vec2_t{ .x = 1.0, .y = 2.0 };

    const p_ptr = @ptrCast([*]f32, &p);

    try std.testing.expectEqual(p.x, p_ptr[0]);
    try std.testing.expectEqual(p.y, p_ptr[1]);
}
