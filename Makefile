TARGET := a.out

C_FLAGS := -Wall -Wextra -Wall -Wfloat-equal -Wundef -Wshadow -Wpointer-arith -Wcast-align -Wstrict-prototypes -Wstrict-overflow=5 -Wwrite-strings -Waggregate-return -Wcast-qual -Wswitch-default -Wswitch-enum -Wconversion -Wunreachable-code
CXX_FLAGS := $(shell g++ -print-file-name=libstdc++.so)
OBJC_FLAGS := -lgnustep-base -fconstant-string-class=NSConstantString -lobjc
SWIFT_FLAGS := $(shell test -d helpers || mkdir helpers; if test -f helpers/swift; then ldd helpers/swift | awk '{print $$3}' | tr '\n' ' '; else echo -n 'print("1");' > helpers/swift.swift; swiftc helpers/swift.swift -o helpers/swift; rm helpers/swift.swift; ldd helpers/swift | awk '{print $$3}' | tr '\n' ' '; fi)
F90_FLAGS := -lgfortran
LUA_FLAGS := -llua
PY_FLAGS := $(shell python3-config --cflags --embed --ldflags)
RUBY_FLAGS := -lruby -I/usr/include/ruby-3.0.0 -I/usr/include/ruby-3.0.0/x86_64-linux
CRYSTAL_FLAGS := -lm -levent -lgc
JS_FLAGS := -I/usr/include/node -lnode -luv 
PERL_FLAGS := $(shell perl -MExtUtils::Embed -e ccopts) $(shell perl -MExtUtils::Embed -e ldopts)


define rm 
	@echo -e "\r\x1b[31mRemoving $(1)\x1b[0m"
	@rm -rf $(1)
endef
$(TARGET): dircheck build/a.o build/b.o build/c.a build/d.o build/e.o build/f.o build/g.o build/h.o build/i.o build/j.a build/k.a build/l.o build/m.o build/n.o build/o.a build/p.o build/q.o
	gdc $(CXX_FLAGS) $(OBJC_FLAGS) $(SWIFT_FLAGS) $(F90_FLAGS) $(LUA_FLAGS) $(PY_FLAGS) $(RUBY_FLAGS) $(CRYSTAL_FLAGS) $(JS_FLAGS)  build/* $(PERL_FLAGS)
	
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
	$(call rm,build/*.autolink)
build/g.o: src/g.mm
	g++ -c -o build/g.o $(OBJC_FLAGS) src/g.mm
build/h.o: src/h.f90
	gfortran -c -o build/h.o src/h.f90
build/i.o: src/i.nim
	nim c --hints:off --nimcache:build/nim.o --noMain --noLinking src/i.nim
	ld -r build/nim.o/*.o -o build/i.o
	$(call rm,build/nim.o)
build/j.a: src/j.go 
	go build -buildmode=c-archive -o build/j.a src/j.go
	$(call rm,build/j.h*)
build/k.a: src/k.zig
	zig build-lib -femit-bin=build/k.a -static -fPIC -fcompiler-rt src/k.zig 
	$(call rm,build/k.a.o)
build/l.o: src/l.lua
	lua utils/gen_lua.lua src/l.lua build/l.c 
	gcc -c  -o build/l.o build/l.c
	$(call rm,build/l.c)
build/m.o: src/m.py
	python3 utils/gen_python.py src/m.py build/m.c
	gcc -c -o build/m.o $(PY_FLAGS) build/m.c 
	$(call rm,build/m.c)
build/n.o: src/n.rb
	ruby utils/gen_ruby.rb src/n.rb build/n.c
	gcc -c -o build/n.o $(RUBY_FLAGS) build/n.c 
	$(call rm,build/n.c)
build/o.a: src/o.cr
	@test -f utils/gen_crystal_cmp || crystal build utils/gen_crystal.cr -o utils/gen_crystal_cmp
	crystal build --emit obj src/o.cr -o build/cr_out
	$(call rm,build/cr_out)
	mv o.o build/o.o
	strip -N main build/o.o
	./utils/gen_crystal_cmp src/o.cr build/o.o build/o.a
	$(call rm,build/o.o)
build/p.o: src/p.js
	node utils/gen_js.js src/p.js build/p.cpp
	g++ -c -o build/p.o build/p.cpp $(JS_FLAGS) 
	$(call rm,build/p.cpp)
build/q.o: src/q.pl
	perl utils/gen_perl.pl src/q.pl build/q.c
	gcc -c -o build/q.o build/q.c $(PERL_FLAGS)
	$(call rm,build/q.c)


dircheck: 
	@mkdir -p build
	@mkdir -p helpers
	@mkdir -p utils
clean: 
	rm build/*
	rm helpers/*
	rm utils/*cmp
.PHONY: clean dircheck all