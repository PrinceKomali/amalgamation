const std = @import("std");
pub export fn zig() callconv(.C) void {
    std.io.getStdOut().writer().print("Sent from Zig\n", .{}) catch unreachable;

}
