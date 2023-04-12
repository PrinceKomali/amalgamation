import sys
import re
f = open(sys.argv[1], "r")
script = f.read()
f.close()
funcs = ""
for line in script.split("\n"):
    m = re.compile("^def [\\w_]*\(").match(line)
    if m: 
        n = m[0][4:-1]
        funcs += f"\nvoid {n}() {{if(!_pinit){{py_init();_pinit=1;}}PyRun_SimpleString(\"{n}()\");}}"
c = """#include <Python.h>
#include <stdlib.h>
int _pinit=0;void py_init() {Py_Initialize(); PyRun_SimpleString(\"""" + script.replace("\n", "\\n").replace('"', '\\"') + "\");}""" + funcs
o = open(sys.argv[2], "w")
o.write(c)
o.close()