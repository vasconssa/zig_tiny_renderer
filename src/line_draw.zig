const std = @import("std");
const math = std.math;
const api_types = @import("api_types.zig");
const vec2_t = api_types.vec2_t;
const rgba_t = api_types.rgba_t;

pub const line_draw_api = struct {
    pub fn draw1(p0: vec2_t, p1: vec2_t, w: u32, h: u32, image: []u8, color: rgba_t) void {
        _ = h;
        //const pos0 = @floatToInt(u32, p0.x) + @floatToInt(u32, p0.y) * w;
        //const pos1 = @floatToInt(u32, p1.x) + @floatToInt(u32, p1.y) * w;
        var im: []rgba_t = @bitCast([]rgba_t, image);

        var t: f32 = 0.0;
        while (t < 1.0) : (t += 0.001) {
            const x = p0.x + (p1.x - p0.x) * t;
            const y = p0.y + (p1.y - p0.y) * t;
            const pos = @floatToInt(u32, x) + @floatToInt(u32, y) * w;
            im[pos] = color;
        }
    }

    pub fn draw2(p0: vec2_t, p1: vec2_t, w: u32, h: u32, image: []u8, color: rgba_t) void {
        _ = h;
        var im: []rgba_t = @bitCast([]rgba_t, image);

        var x: f32 = p0.x;
        while (x <= p1.x) : (x += 1.0) {
            const t = (x - p0.x) / (p1.x - p0.x);
            const y = p0.y * (1.0 - t) + p1.y * t;
            const pos = @floatToInt(u32, x) + @floatToInt(u32, y) * w;
            im[pos] = color;
        }
    }

    pub fn draw(v0: vec2_t, v1: vec2_t, w: u32, h: u32, image: []u8, color: rgba_t) void {
        _ = h;
        var im: []rgba_t = @bitCast([]rgba_t, image);

        var p0 = v0;
        var p1 = v1;
        var steep: bool = false;
        const dx = p1.x - p0.x;
        const dy = p1.y - p0.y;

        if (math.fabs(dx) < math.fabs(dy)) {
            std.mem.swap(f32, &p0.x, &p0.y);
            std.mem.swap(f32, &p1.x, &p1.y);
            steep = true;
        }

        if (dx < 0.0) {
            std.mem.swap(f32, &p0.x, &p1.x);
            std.mem.swap(f32, &p0.y, &p1.y);
        }

        var x: f32 = p0.x;
        while (x <= p1.x) : (x += 1.0) {
            const t = (x - p0.x) / (p1.x - p0.x);
            const y = p0.y * (1.0 - t) + p1.y * t;
            const pos = if (steep) @floatToInt(u32, x) + @floatToInt(u32, y) * w else @floatToInt(u32, y) + @floatToInt(u32, x) * w;
            im[pos] = color;
        }
    }
};
