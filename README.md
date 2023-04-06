# I was bored, okay?
This project builds a single executable from 10 different languages:
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

If you want to build this project yourself (are you crazy?) and you use Linux, just make sure you have all the languages installed (along with `gnustep` for Objective C(++)) and run `make`. If you're on Windows, use WSL.
## Goals

I want to try adding the following languages too

- Python via <Python.h> (being troublesome)
- Javascript via V8 (testing but no success)
- Lua via <lua.h> (I'm close)
- Java (and maybe other JVM languages) via JNI 
- C# via Mono (if it's even possible)
