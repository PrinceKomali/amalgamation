package utils;

class GenHaxe {
	public static function main() {
		var args = Sys.args();
        if(args.length < 2) {
            trace("Need 2 args");
            return;
        }
		var fname = args[0];
		var file = sys.io.File.getContent(fname).split("\n");
		var line = file.shift();
		var class_line = "";
		while (!StringTools.startsWith(line, "class")) {
			line = file.shift();
		}
		class_line = line;
		var func_names = [];
		while (StringTools.trim(line) != "}") {
			line = file.shift();
			if (StringTools.contains(StringTools.trim(line), "static function")) {
				func_names.push(StringTools.trim(line.split("function ")[1].split("(")[0]));
			}
		}

		var class_name = class_line.split("class ")[1].split(" ")[0];
		sys.io.File.copy(fname, "helpers/" + class_name + ".hx");
		Sys.setCwd("helpers");
		Sys.command("haxe", ["-cpp", "hx", "-D", "static_link", class_name]);
		var ln_cc = "namespace " + class_name + "_obj {";
		for (func in func_names) {
			ln_cc += "void " + func + "();";
		}
		ln_cc += "}\nvoid __boot_all(); namespace hx { void Boot(); void SetTopOfStack(int*,bool); } int _hx_n=0;int _hx_init=0;void hxinit() { if(!_hx_init){_hx_init=1;hx::SetTopOfStack(&_hx_n, true); hx::Boot();__boot_all();}}";
        for(func in func_names) {
            ln_cc += "extern \"C\" void " + func + "() { hxinit(); " + class_name + "_obj::" + func + "(); }";
        }
        sys.io.File.saveContent("ln_hx.cc", ln_cc);
        Sys.command("g++ -c -o ln_hx.o ln_hx.cc");
        Sys.setCwd("..");
        sys.io.File.copy("helpers/hx/liboutput.a", args[1]);
        Sys.command("ar r " + args[1] + " helpers/ln_hx.o");
	}
}
