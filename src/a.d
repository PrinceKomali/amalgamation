import std.stdio;
extern (C) {
    void c();
    void rs();
    void cpp();
    void objc();
    void swift();
    void objcpp();
    void fortran();
    void nim();
    void golang();
    void zig();
    void _lua();
}
void main() {
    c();
    rs();
    cpp();
    objc();
    swift();
    objcpp();
    fortran();
    nim();
    golang();
    zig();
    _lua();
    writeln("Sent from D");
}