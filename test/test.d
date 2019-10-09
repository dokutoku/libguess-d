/**
 * libguess sample program
 */
module libguess_d.sample.test;


private static import std.stdio;
private static import libguess_d.libguess;

void main(string[] argv)

	do
	{
		static import std.stdio;
		static import libguess_d.libguess;

		if (argv.length != 2) {
			std.stdio.stderr.writefln(`usage: %s <file_name>`, argv[0]);

			return;
		}

		std.stdio.File fp = std.stdio.File(argv[1], `r`);
		auto fp_range = fp.byLine();
		size_t line_number = 1;

		foreach (line; fp_range) {
			std.stdio.writeln(`line: `, line_number);
			std.stdio.writeln(`    length = `, line.length);
			std.stdio.writeln(`    ar = `, libguess_d.libguess.encoding_name(libguess_d.libguess.guess_ar(line)));
			std.stdio.writeln(`    cn = `, libguess_d.libguess.encoding_name(libguess_d.libguess.guess_cn(line)));
			std.stdio.writeln(`    gr = `, libguess_d.libguess.encoding_name(libguess_d.libguess.guess_gr(line)));
			std.stdio.writeln(`    hw = `, libguess_d.libguess.encoding_name(libguess_d.libguess.guess_hw(line)));
			std.stdio.writeln(`    ja = `, libguess_d.libguess.encoding_name(libguess_d.libguess.guess_ja(line)));
			std.stdio.writeln(`    kr = `, libguess_d.libguess.encoding_name(libguess_d.libguess.guess_kr(line)));
			//std.stdio.writeln(`    ru = `, libguess_d.libguess.encoding_name(libguess_d.libguess.guess_ru(line)));
			std.stdio.writeln(`    tr = `, libguess_d.libguess.encoding_name(libguess_d.libguess.guess_tr(line)));
			std.stdio.writeln(`    tw = `, libguess_d.libguess.encoding_name(libguess_d.libguess.guess_tw(line)));
			++line_number;
		}

		fp.close();
	}
