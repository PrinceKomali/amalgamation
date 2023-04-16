# I was bored, okay?
This project builds a single 31.3-megabyte executable from 19 different languages:
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
- Ruby (via <ruby.h>)
- Crystal
- Javascript (via <node.h>)
- Perl (via <perl.h>)
- LLVM IR
- Haskell

If you want to build this project yourself (are you crazy?) and you use Linux, just make sure you have all the languages installed (along with `gnustep` for Objective C(++)) and run `make`. If you're on Windows, use WSL.
## Goals

I want to try adding the following languages too

- Assembly (why is it not working)
- Ada (Close but seems to require multiple source files)
- Other interpreted/compiled languages


