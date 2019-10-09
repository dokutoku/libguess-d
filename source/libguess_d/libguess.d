/**
 *
 * See_Also:
 *      http://www.honeyplanet.jp/download.html#libguess
 *      http://hg.honeyplanet.jp/libguess/
 */
module libguess_d.libguess;


public import libguess_d.encoding;
public import libguess_d.guess.common;
public import libguess_d.guess.cjk;
//public import libguess_d.guess.russian;

/**
 * 
 *
 * Params:
 *      input = input string
 *
 * Returns: Character encoding or null
 */
pure nothrow @trusted @nogc
libguess_d.encoding.libguess_encoding guess_encoding(const char[] input, const libguess_d.encoding.supported_lang lang)

	in
	{
		switch (lang) {
			case lang.ar:
			case lang.cn:
			case lang.gr:
			case lang.hw:
			case lang.ja:
			case lang.kr:
			//case lang.ru:
			case lang.tr:
			case lang.tw:
				break;

			default:
				assert(0);
		}
	}

	do
	{
		static import libguess_d.encoding;
		static import libguess_d.guess.cjk;
		static import libguess_d.guess.common;
		//static import libguess_d.guess.russian;

		switch (lang) {
			case lang.ar:
				return libguess_d.guess.common.guess_ar(input);

			case lang.cn:
				return libguess_d.guess.cjk.guess_cn(input);

			case lang.gr:
				return libguess_d.guess.common.guess_gr(input);

			case lang.hw:
				return libguess_d.guess.common.guess_hw(input);

			case lang.ja:
				return libguess_d.guess.cjk.guess_ja(input);

			case lang.kr:
				return libguess_d.guess.cjk.guess_kr(input);

			/*
			case lang.ru:
				return libguess_d.guess.russian.guess_ru(input);
			*/

			case lang.tr:
				return libguess_d.guess.common.guess_tr(input);

			case lang.tw:
				return libguess_d.guess.cjk.guess_tw(input);

			default:
				return libguess_d.encoding.libguess_encoding.undefined;
		}
	}
