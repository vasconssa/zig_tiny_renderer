const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;
const testing = std.testing.allocator;

pub const wavefront_obj_t = struct {
    a: Allocator,
    v: []f32,
    f: []u32,
};

pub fn load_wavefront_object(filename: []const u8, allocator: Allocator) !wavefront_obj_t {
    var obj = wavefront_obj_t{ .a = allocator, .v = undefined, .f = undefined };
    var buffer = try std.fs.cwd().readFileAlloc(obj.a, filename, 50 * 1024 * 1024 * 1024);
    var b = std.mem.tokenize(u8, buffer, "\n");
    while (b.next()) |v| {
        //var v = b.peek().?;
        if (v[0] != 'v') break;
        std.debug.print("v: {s}\n", .{v});
    }
    obj.a.free(buffer);

    return obj;
}

test "Load wavefront" {
    var obj = try load_wavefront_object("assets/african_head.obj", testing);
    _ = obj;
}
