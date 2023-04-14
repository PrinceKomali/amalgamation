# Crystal is funky and needs an init script
script = File.read(ARGV[0])
if !File.file?("helpers/cr_init.o") 
    File.write("helpers/cr_init.c", "void cr_init() {GC_init();__crystal_main(0, (int **)0);}")
    system "cd helpers && gcc -c -o cr_init.o cr_init.c "
end
funcs = ""
symbols = Array(String).new
script.split("\n").each do|line|
   if line =~ /^fun [\w_]* = [\w_]* *[\(:]/ 
        n = line.split("=")[1].split("(")[0].lstrip(" ");
        symbols << n
        funcs += "void #{n}() {if(!_cr_init){_cr_init=1;cr_init();}export_#{n}();}"
   end
end
symbols.each do|symbol|
    system "objcopy --redefine-sym #{symbol}=export_#{symbol} #{ARGV[1]} #{ARGV[1]}"
end
system "strip -N main #{ARGV[1]}"
c = "int _cr_init=0;" + funcs;
File.write("helpers/cr.c", c)
system "gcc -c helpers/cr.c -o helpers/cr.o"
system "ar r #{ARGV[2]} #{ARGV[1]} helpers/cr.o helpers/cr_init.o"