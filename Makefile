TARGET := a.out

CXX_FLAGS := $(shell g++ -print-file-name=libstdc++.so)
OBJC_FLAGS := -lgnustep-base -fconstant-string-class=NSConstantString -lobjc
SWIFT_FLAGS := $(shell test -d helpers || mkdir helpers; if test -f helpers/swift; then ldd helpers/swift | awk '{print $$3}' | tr '\n' ' '; else echo -n 'print("1");' > helpers/swift.swift; swiftc helpers/swift.swift -o helpers/swift; rm helpers/swift.swift; ldd helpers/swift | awk '{print $$3}' | tr '\n' ' '; fi)
F90_FLAGS := -lgfortran

$(TARGET): dircheck build/a.o build/b.o build/c.a build/d.o build/e.o build/f.o build/g.o build/h.o build/i.o build/j.a
	gdc $(CXX_FLAGS) $(OBJC_FLAGS) $(SWIFT_FLAGS) $(F90_FLAGS) build/*
build/a.o: src/a.d
	gdc -c -o build/a.o src/a.d 
build/b.o: src/b.c
	gcc -c -o build/b.o src/b.c
build/c.a: src/c.rs
	rustc --crate-type=staticlib -o build/c.a src/c.rs
build/d.o: src/d.cpp
	g++ -c -o build/d.o src/d.cpp
build/e.o: src/e.m
	gcc -c -o build/e.o $(OBJC_FLAGS) src/e.m
build/f.o: src/f.swift
	swiftc -c -o build/f.o -parse-as-library -emit-object src/f.swift
	@rm build/*.autolink 
build/g.o: src/g.mm
	g++ -c -o build/g.o $(OBJC_FLAGS) src/g.mm
build/h.o: src/h.f90
	gfortran -c -o build/h.o src/h.f90
build/i.o: src/i.nim
	nim c --nimcache:build/nim.o --noMain --noLinking src/i.nim
	ld -r build/nim.o/*.o -o build/i.o
	@rm -rf build/nim.o
build/j.a: src/j.go 
	go build -buildmode=c-archive -o build/j.a src/j.go
dircheck: 
	@mkdir -p build
	@mkdir -p helpers
clean: 
	rm build/*
.PHONY: clean dircheck all