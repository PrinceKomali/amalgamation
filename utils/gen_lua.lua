local fname = ""
for q in string.gmatch(arg[1], "[/%w]*.") do
    fname = q:sub(0, #q - 1)
    break
end
print(fname, mname)
local f = io.open(arg[1], "r")
io.input(f)
local script = ""
local funcs = ""
while true do
    line = io.read()
    if(line == nil) then 
        break 
    end 
    script = script .. "\n" .. line
    if(line:find("^ *function")) then 
        local s = "";
        for q in line:gmatch("[_%w]*[(]") do
            s =q:sub(0, #s - 2)
            break
        end
        funcs = funcs .. "\nvoid " .. s .. "() { if(!_linit){lua_init();_linit=1;}luaL_dostring(lua, \"" .. s .. "()\"); }"
    end
end
local c = "#include <lua.h>\
#include <lualib.h>\
#include <lauxlib.h>\
int _linit = 0;lua_State *lua;void lua_init(){lua = luaL_newstate();luaL_openlibs(lua);luaL_dostring(lua, \"" .. script:gsub("\n", "\\n"):gsub('"', '\\"') .. "\");}" .. funcs
io.output(arg[2])
io.write(c)