import std.stdio;
extern (C) {
    void c();
    void rs();
    void cpp();
    void objc();
    void swift();
    void objcpp();
    void fortran();
    void v();
    void py();
    void nim();
    void zig();
    void ruby();
    void perl();
    void haxe();
    void _lua();
    void golang();
    void crystal();
    void javascript();
    void llvm_ir();
    void haskell();
}
void main() {
    c();
    rs();
    cpp();
    objc();
    swift();
    objcpp();
    fortran();
    v();
    py();
    nim();
    zig();
    ruby();
    _lua();
    golang();
    llvm_ir();
    crystal();
    perl();
    haskell();
    haxe();
    javascript(); // takes a long time for some reason
    writeln("Sent from D");
}