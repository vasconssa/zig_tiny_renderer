const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("zig_tiny_renderer", "src/main.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.linkLibC();
    exe.addCSourceFile("3rd_party/stb_image/stb_image_write_impl.c", &[_][]const u8{"-std=c99"});
    exe.addIncludeDir("3rd_party");
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    //const write_tests = b.addTest("src/stb_image_write.zig");
    //write_tests.addCSourceFile("3rd_party/stb_image/stb_image_write_impl.c", &[_][]const u8{"-std=c99"});
    //write_tests.addIncludeDir("3rd_party");
    //write_tests.setTarget(target);
    //write_tests.setBuildMode(mode);
    //write_tests.linkLibC();

    const exe_tests = b.addTest("src/main.zig");
    exe_tests.setTarget(target);
    exe_tests.setBuildMode(mode);
    exe_tests.linkLibC();
    exe_tests.addCSourceFile("3rd_party/stb_image/stb_image_write_impl.c", &[_][]const u8{"-std=c99"});
    exe_tests.addIncludeDir("3rd_party");

    const api_tests = b.addTest("src/api_types.zig");
    api_tests.setTarget(target);
    api_tests.setBuildMode(mode);

    const wav_tests = b.addTest("src/wavefront_obj.zig");
    wav_tests.setTarget(target);
    wav_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&exe_tests.step);
    test_step.dependOn(&api_tests.step);
    test_step.dependOn(&wav_tests.step);
}
