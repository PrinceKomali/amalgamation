TARGET := a.out

GHC_PATH = "/usr/lib/ghc-"$(shell ghc --version | awk '{print $$8}')
GHC_LIB_PATHS := $(shell find $(GHC_PATH) -maxdepth 1 -type d | awk '{print "-L"$$0}' | tr '\n' ' ')

C_FLAGS := -Wall -Wextra -Wall -Wfloat-equal -Wundef -Wshadow -Wpointer-arith -Wcast-align -Wstrict-prototypes -Wstrict-overflow=5 -Wwrite-strings -Waggregate-return -Wcast-qual -Wswitch-default -Wswitch-enum -Wconversion -Wunreachable-code
CXX_FLAGS := $(shell g++ -print-file-name=libstdc++.so)
OBJC_FLAGS := -lgnustep-base -fconstant-string-class=NSConstantString -lobjc
SWIFT_FLAGS := $(shell test -d helpers || mkdir helpers; if test -f helpers/swift; then ldd helpers/swift | awk '{print $$3}' | tr '\n' ' '; else echo -n 'print("1");' > helpers/swift.swift; swiftc helpers/swift.swift -o helpers/swift; rm helpers/swift.swift; ldd helpers/swift | awk '{print $$3}' | tr '\n' ' '; fi)
F90_FLAGS := -lgfortran
LUA_FLAGS := -llua
PY_FLAGS := $(shell python3-config --cflags --embed --ldflags)
RUBY_FLAGS := -lruby -I/usr/include/ruby-3.0.0 -I/usr/include/ruby-3.0.0/x86_64-linux
CRYSTAL_FLAGS := -lm -levent -lgc -lpcre2-8
JS_FLAGS := -I/usr/include/node -lnode -luv 
PERL_FLAGS := $(shell perl -MExtUtils::Embed -e ccopts) $(shell perl -MExtUtils::Embed -e ldopts)
HASKELL_FLAGS := -no-pie -fno-PIC -Wl,--no-as-needed,--gc-sections,-u,base_GHCziTopHandler_runIO_closure,-u,base_GHCziTopHandler_runNonIO_closure,-u,ghczmprim_GHCziTuple_Z0T_closure,-u,ghczmprim_GHCziTypes_True_closure,-u,ghczmprim_GHCziTypes_False_closure,-u,base_GHCziPack_unpackCString_closure,-u,base_GHCziWeak_runFinalizzerBatch_closure,-u,base_GHCziIOziException_stackOverflow_closure,-u,base_GHCziIOziException_heapOverflow_closure,-u,base_GHCziIOziException_allocationLimitExceeded_closure,-u,base_GHCziIOziException_blockedIndefinitelyOnMVar_closure,-u,base_GHCziIOziException_blockedIndefinitelyOnSTM_closure,-u,base_GHCziIOziException_cannotCompactFunction_closure,-u,base_GHCziIOziException_cannotCompactPinned_closure,-u,base_GHCziIOziException_cannotCompactMutable_closure,-u,base_GHCziIOPort_doubleReadException_closure,-u,base_ControlziExceptionziBase_nonTermination_closure,-u,base_ControlziExceptionziBase_nestedAtomically_closure,-u,base_GHCziEventziThread_blockedOnBadFD_closure,-u,base_GHCziExceptionziType_divZZeroException_closure,-u,base_GHCziExceptionziType_underflowException_closure,-u,base_GHCziExceptionziType_overflowException_closure,-u,base_GHCziConcziSync_runSparks_closure,-u,base_GHCziConcziIO_ensureIOManagerIsRunning_closure,-u,base_GHCziConcziIO_interruptIOManager_closure,-u,base_GHCziConcziIO_ioManagerCapabilitiesChanged_closure,-u,base_GHCziConcziSignal_runHandlersPtr_closure,-u,base_GHCziTopHandler_flushStdHandles_closure,-u,base_GHCziTopHandler_runMainIO_closure,-u,ghczmprim_GHCziTypes_Czh_con_info,-u,ghczmprim_GHCziTypes_Izh_con_info,-u,ghczmprim_GHCziTypes_Fzh_con_info,-u,ghczmprim_GHCziTypes_Dzh_con_info,-u,ghczmprim_GHCziTypes_Wzh_con_info,-u,base_GHCziPtr_Ptr_con_info,-u,base_GHCziPtr_FunPtr_con_info,-u,base_GHCziInt_I8zh_con_info,-u,base_GHCziInt_I16zh_con_info,-u,base_GHCziInt_I32zh_con_info,-u,base_GHCziInt_I64zh_con_info,-u,base_GHCziWord_W8zh_con_info,-u,base_GHCziWord_W16zh_con_info,-u,base_GHCziWord_W32zh_con_info,-u,base_GHCziWord_W64zh_con_info,-u,base_GHCziStable_StablePtr_con_info,-u,hs_atomic_add8,-u,hs_atomic_add16,-u,hs_atomic_add32,-u,hs_atomic_add64,-u,hs_atomic_sub8,-u,hs_atomic_sub16,-u,hs_atomic_sub32,-u,hs_atomic_sub64,-u,hs_atomic_and8,-u,hs_atomic_and16,-u,hs_atomic_and32,-u,hs_atomic_and64,-u,hs_atomic_nand8,-u,hs_atomic_nand16,-u,hs_atomic_nand32,-u,hs_atomic_nand64,-u,hs_atomic_or8,-u,hs_atomic_or16,-u,hs_atomic_or32,-u,hs_atomic_or64,-u,hs_atomic_xor8,-u,hs_atomic_xor16,-u,hs_atomic_xor32,-u,hs_atomic_xor64,-u,hs_cmpxchg8,-u,hs_cmpxchg16,-u,hs_cmpxchg32,-u,hs_cmpxchg64,-u,hs_xchg8,-u,hs_xchg16,-u,hs_xchg32,-u,hs_xchg64,-u,hs_atomicread8,-u,hs_atomicread16,-u,hs_atomicread32,-u,hs_atomicread64,-u,hs_atomicwrite8,-u,hs_atomicwrite16,-u,hs_atomicwrite32,-u,hs_atomicwrite64 $(GHC_LIB_PATHS) -lHStext-1.2.5.0 -lHSinteger-gmp-1.1 -lHSghc-9.0.2 -lHSterminfo-0.4.1.5 -lHSprocess-1.6.13.2 -lHShpc-0.6.1.0 -lHSghci-9.0.2 -lHSghc-heap-9.0.2 -lHSghc-boot-9.0.2 -lHSexceptions-0.10.4 -lHStemplate-haskell-2.17.0.0 -lHSpretty-1.1.3.6 -lHSghc-boot-th-9.0.2 -lHSstm-2.5.0.0 -lHSmtl-2.2.2 -lHStransformers-0.5.6.2 -lHSdirectory-1.3.6.2 -lHSunix-2.7.2.2 -lHStime-1.9.3 -lHSfilepath-1.4.2.1 -lHSbinary-0.8.8.0 -lHScontainers-0.6.4.1 -lHSbytestring-0.10.12.1 -lHSdeepseq-1.4.5.0 -lHSarray-0.5.4.0 -lHSbase-4.15.1.0 -lHSghc-bignum-1.1 -lHSghc-prim-0.7.0 -lHSrts -ltinfo -lgmp -lc -lm -lrt -ldl -lffi -lnuma


define rm 
	@echo -e "\r\x1b[31mRemoving $(1)\x1b[0m"
	@rm -rf $(1)
endef
$(TARGET): dircheck build/a.o build/b.o build/c.a build/d.o build/e.o build/f.o build/g.o build/h.o build/i.o build/j.a build/k.a build/l.o build/m.o build/n.o build/o.a build/p.o build/q.o build/r.o build/s.a build/t.o build/u.a
	gdc $(CXX_FLAGS) $(OBJC_FLAGS) $(SWIFT_FLAGS) $(F90_FLAGS) $(LUA_FLAGS) $(PY_FLAGS) $(RUBY_FLAGS) $(CRYSTAL_FLAGS) $(JS_FLAGS) build/* $(PERL_FLAGS) $(HASKELL_FLAGS)
	
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
build/r.o: src/r.ll
	clang -c -o build/r.o src/r.ll
build/s.a: src/s.hs 
	ghc -tmpdir helpers -keep-tmp-files -no-keep-hi-files -no-keep-o-files src/s.hs 
	{ \
		printf "_hs_init = 0;"; \
		nm src/s.o | \
			grep -E '^[0-9a-f]{16} T' | \
			awk '{print $$3}' | \
			xargs -I {} echo 'void {}() {  if(!_hs_init){_hs_init=1;int argc = 1;char **argv = (char **)malloc(sizeof(char *));argv[0] = strdup("hi");hs_init(&argc, &argv);}export_{}();}'; \
	} > helpers/funcs.c 
	gcc -c -o helpers/funcs.o helpers/funcs.c
	ar r build/s.a helpers/ghc*/*.o
	nm src/s.o | grep -E '^[0-9a-f]{16} T' | awk '{print $$3}' | xargs -I {} objcopy --redefine-sym {}=export_{} build/s.a build/s.a
	ar r build/s.a helpers/funcs.o
	$(call rm,helpers/ghc*)
	$(call rm,src/*.o)
	$(call rm,src/*.h)
	$(call rm,src/*.hi)
build/t.o:
	v -o build/t.o src/t.v -c
build/u.a:
	haxe --run utils.GenHaxe src/u.hx build/u.a
dircheck: 
	@mkdir -p build
	@mkdir -p helpers
	@mkdir -p utils
clean: 
	rm build/* -rf
	rm helpers/* -rf
	rm utils/*cmp -rf
.PHONY: clean dircheck all
