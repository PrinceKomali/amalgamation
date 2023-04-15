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
    void zig();
    void ruby();
    void perl();
    void _lua();
    void golang();
    void crystal();
    void javascript();
}
void main() {
    c();
    rs();
    cpp();
    objc();
    swift();
    objcpp();
    fortran();
    py();
    nim();
    zig();
    ruby();
    _lua();
    golang();
    crystal();
    perl();
    javascript(); // takes a long time for some reason
    writeln("Sent from D");
}