const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe_mod = b.createModule(.{
        .root_source_file = b.path("main.zig"),
        .target = target,
        .optimize = optimize,
    });

    const exe = b.addExecutable(.{
        .name = "scratch",
        .root_module = exe_mod,
    });

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);

    // by making run step depends on install step
    // it will run directly from the install folder instead of the cache
    run_cmd.step.dependOn(b.getInstallStep());

    // create a run step
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    // pass build run -- arg1 arg2 to the executable
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    // create a test
    const exe_test = b.addTest(.{
        .root_module = exe_mod,
    });

    // no need for install artifact

    // add a run artifact
    const test_cmd = b.addRunArtifact(exe_test);

    // create a test step
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&test_cmd.step);
}
