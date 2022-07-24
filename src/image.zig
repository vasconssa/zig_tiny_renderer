const std = @import("std");
const ciw = @cImport({
    @cInclude("stb_image/stb_image_write.h");
});

pub const png_writer_api = struct {
    pub fn write(filename: []const u8, w: u32, h: u32, num_channels: u32, bytes: []const u8) void {
        _ = ciw.stbi_write_png(@ptrCast([*c]const u8, filename), @intCast(c_int, w), @intCast(c_int, h), @intCast(c_int, num_channels), @ptrCast(*const anyopaque, &bytes[0]), @intCast(c_int, w * num_channels));
    }
};
