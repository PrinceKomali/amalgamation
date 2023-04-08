# I was bored, okay?
This project builds a single executable from 13 different languages:
- C (gcc)
- D (gdc)
- Rust
- C++ (g++)
- Objective C (gcc)
- Objective C++ (g++)
- Swift
- Fortran (gfortan)
- Go
- Nim
- Zig  
- Lua (via <lua.h>)  
- Python (via <Python.h>)

If you want to build this project yourself (are you crazy?) and you use Linux, just make sure you have all the languages installed (along with `gnustep` for Objective C(++)) and run `make`. If you're on Windows, use WSL.
## Goals

I want to try adding the following languages too

- Javascript via V8 (testing but no success)
- Java (and maybe other JVM languages) via JNI 
- C# via Mono (if it's even possible)

