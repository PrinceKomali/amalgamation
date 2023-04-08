const std = @import("std");
pub export fn zig() callconv(.C) void {
    std.debug.print("Sent from Zig\n", .{});
}
