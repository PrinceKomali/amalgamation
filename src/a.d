import std.stdio;
extern (C) {
    void c();
    void rs();
    void cpp();
    void objc();
    void swift();
    void objcpp();
    void fortran();
    void py();
    void nim();
    void ruby();
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
    py();
    ruby();
    writeln("Sent from D");
}