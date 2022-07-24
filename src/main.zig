const std = @import("std");
const png_writer_api = @import("image.zig").png_writer_api;
const line_draw_api = @import("line_draw.zig").line_draw_api;
const api_types = @import("api_types.zig");
const vec2_t = api_types.vec2_t;
const rgba_t = api_types.rgba_t;

pub fn main() anyerror!void {
    const w = 100;
    const h = 100;
    const channels = 4;

    var bytes = [_]u8{0} ** (w * h * channels);
    var y: u32 = 0;
    while (y < h) : (y += 1) {
        var x: u32 = 0;
        while (x < w) : (x += 1) {
            //const r = @intToFloat(f32, x) / @intToFloat(f32, w);
            //const g = @intToFloat(f32, y) / @intToFloat(f32, h);
            //const b = @intToFloat(f32, x * y) / @intToFloat(f32, w * h);
            const index = (y * w + x) * 4;
            //bytes[index + 0] = @floatToInt(u8, r * 255.0);
            //bytes[index + 1] = @floatToInt(u8, g * 255.0);
            //bytes[index + 2] = @floatToInt(u8, b * 255.0);
            bytes[index + 3] = 255;
        }
    }

    const red = rgba_t{ .r = 255, .g = 0, .b = 0, .a = 255 };
    const green = rgba_t{ .r = 0, .g = 255, .b = 0, .a = 255 };
    const white = rgba_t{ .r = 255, .g = 255, .b = 255, .a = 255 };
    _ = red;
    _ = green;
    _ = white;

    line_draw_api.draw(.{ .x = 13.0, .y = 20.0 }, .{ .x = 80.0, .y = 40.0 }, w, h, bytes[0..], white);
    line_draw_api.draw(.{ .x = 20.0, .y = 13.0 }, .{ .x = 40.0, .y = 80.0 }, w, h, bytes[0..], red);
    line_draw_api.draw(.{ .x = 80.0, .y = 40.0 }, .{ .x = 13.0, .y = 20.0 }, w, h, bytes[0..], green);

    png_writer_api.write("test.png", w, h, channels, bytes[0..]);
}

test "Image write test" {
    try std.testing.expectEqual(10, 3 + 7);
}
