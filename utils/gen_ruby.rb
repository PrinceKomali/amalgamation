script = File.read(ARGV[0])
funcs = ""
script.split("\n").each do|line|
   if line =~ /^def [\w_]*\(/ 
        n = line.split("def ")[1].split("(")[0]
        funcs += "void #{n}() {if(!_rb_init){_rb_init=1;rb_init();}rb_eval_string(\"#{n}()\");}"
   end
end
c = "#include <stdio.h>
#include <ruby/ruby.h>
int _rb_init = 0;void rb_init () {ruby_init();rb_eval_string(\"#{script.gsub("\n", "\\n").gsub("\"", "\\\"")}\");}" + funcs
File.write(ARGV[1], c)