/**
 * 
 *
 * License: BSD 3-clause
 */
module libguess_d.guess.common;


private static import libguess_d.dfa;
private static import libguess_d.encoding;

pure nothrow @safe @nogc
private void common_first_check(const char[] input, ref libguess_d.encoding.libguess_encoding rv)

	body
	{
		static import libguess_d.dfa;

		rv = libguess_d.dfa.check_UTF16_BOM(input);
	}

/**
 * 
 *
 * Params:
 *      input = input string
 *
 * Returns: Character encoding or null
 */
pure nothrow @trusted @nogc
libguess_d.encoding.libguess_encoding guess_common(libguess_d.encoding.supported_lang lang)(const char[] input)

	body
	{
		static import libguess_d.dfa;
		static import libguess_d.encoding;

		if (input.length == 0) {
			return libguess_d.encoding.libguess_encoding.undefined;
		}

		static if (lang == libguess_d.encoding.supported_lang.ar) {
			libguess_d.dfa.guess_dfa[3] order = [libguess_d.encoding.utf8, libguess_d.encoding.iso8859_6, libguess_d.encoding.cp1256];
		} else static if (lang == libguess_d.encoding.supported_lang.gr) {
			libguess_d.dfa.guess_dfa[3] order = [libguess_d.encoding.utf8, libguess_d.encoding.iso8859_7, libguess_d.encoding.cp1253];
		} else static if (lang == libguess_d.encoding.supported_lang.hw) {
			libguess_d.dfa.guess_dfa[3] order = [libguess_d.encoding.utf8, libguess_d.encoding.iso8859_8, libguess_d.encoding.cp1255];
		} else static if (lang == libguess_d.encoding.supported_lang.tr) {
			libguess_d.dfa.guess_dfa[3] order = [libguess_d.encoding.utf8, libguess_d.encoding.iso8859_9, libguess_d.encoding.cp1254];
		} else {
			static assert(0);
		}

		libguess_d.encoding.libguess_encoding rv = libguess_d.encoding.libguess_encoding.undefined;

		.common_first_check(input, rv);

		if (rv != libguess_d.encoding.libguess_encoding.undefined) {
			return rv;
		}

		for (size_t i = 0; i < input.length; i++) {
			ubyte c = cast(ubyte)(input[i]);

			rv = libguess_d.dfa.dfa_process(order, c);

			if (rv != libguess_d.encoding.libguess_encoding.undefined) {
				return rv;
			}

			if (libguess_d.dfa.dfa_none(order)) {
				/* we ran out the possibilities */
				return libguess_d.encoding.libguess_encoding.undefined;
			}
		}

		rv = libguess_d.dfa.dfa_top(order);

		return (rv != libguess_d.encoding.libguess_encoding.undefined) ? (rv) : (libguess_d.encoding.libguess_encoding.undefined);
	}

alias guess_ar = .guess_common!(libguess_d.encoding.supported_lang.ar);
alias guess_gr = .guess_common!(libguess_d.encoding.supported_lang.gr);
alias guess_hw = .guess_common!(libguess_d.encoding.supported_lang.hw);
alias guess_tr = .guess_common!(libguess_d.encoding.supported_lang.tr);
