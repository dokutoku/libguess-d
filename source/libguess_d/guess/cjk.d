/*
 * This code is derivative of guess.c of Gauche-0.8.3.
 * The following is the original copyright notice.
 */

/*
 * guess.c - guessing character encoding
 *
 *   Copyright (c) 2000-2003 Shiro Kawai, All rights reserved.
 *
 *   Redistribution and use in source and binary forms, with or without
 *   modification, are permitted provided that the following conditions
 *   are met:
 *
 *   1. Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *
 *   2. Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *
 *   3. Neither the name of the authors nor the names of its contributors
 *      may be used to endorse or promote products derived from this
 *      software without specific prior written permission.
 *
 *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 *   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *   TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *   PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */
/**
 * 
 *
 * License: BSD 3-clause
 */
module libguess_d.guess.cjk;


private static import libguess_d.dfa;
private static import libguess_d.encoding;

pure nothrow @safe @nogc
private void cjk_first_check(const char[] input, ref libguess_d.encoding.libguess_encoding rv)

	do
	{
		static import libguess_d.dfa;

		if (input[0] != 0x1B) {
			rv = libguess_d.dfa.check_UTF16_BOM(input);
		}
	}

/**
 * Inferring character encoding from a Japanese string
 *
 * Params:
 *      input = input string
 *
 * Returns: Character encoding or null
 */
pure nothrow @trusted @nogc
public libguess_d.encoding.libguess_encoding guess_ja(const char[] input)

	in
	{
	}

	do
	{
		static import libguess_d.dfa;
		static import libguess_d.encoding;

		if (input.length == 0) {
			return libguess_d.encoding.libguess_encoding.undefined;
		}

		libguess_d.dfa.guess_dfa[3] ja_order = [libguess_d.encoding.utf8, libguess_d.encoding.sjis, libguess_d.encoding.eucjp];
		libguess_d.encoding.libguess_encoding rv = libguess_d.encoding.libguess_encoding.undefined;

		.cjk_first_check(input, rv);

		if (rv != libguess_d.encoding.libguess_encoding.undefined) {
			return rv;
		}

		for (size_t i = 0; i < input.length; i++) {
			ubyte c = cast(ubyte)(input[i]);

			/* special treatment of iso-2022 escape sequence */
			if (c == 0x1B) {
				if (i < input.length - 1) {
					c = cast(ubyte)(input[++i]);

					if ((c == '$') || (c == '(')) {
						return libguess_d.encoding.libguess_encoding.ISO_2022_JP;
					}
				}
			}

			rv = libguess_d.dfa.dfa_process(ja_order, c);

			if (rv != libguess_d.encoding.libguess_encoding.undefined) {
				return rv;
			}

			if (libguess_d.dfa.dfa_none(ja_order)) {
				/* we ran out the possibilities */
				return libguess_d.encoding.libguess_encoding.undefined;
			}
		}

		rv = libguess_d.dfa.dfa_top(ja_order);

		return (rv != libguess_d.encoding.libguess_encoding.undefined) ? (rv) : (libguess_d.encoding.libguess_encoding.undefined);
	}

/**
 * Inferring character encoding from a Taiwanese string
 *
 * Params:
 *      input = input string
 *
 * Returns: Character encoding or null
 */
pure nothrow @trusted @nogc
public libguess_d.encoding.libguess_encoding guess_tw(const char[] input)

	in
	{
	}

	do
	{
		static import libguess_d.dfa;
		static import libguess_d.encoding;

		if (input.length == 0) {
			return libguess_d.encoding.libguess_encoding.undefined;
		}

		libguess_d.dfa.guess_dfa[2] tw_order = [libguess_d.encoding.utf8, libguess_d.encoding.big5];
		libguess_d.encoding.libguess_encoding rv = libguess_d.encoding.libguess_encoding.undefined;

		.cjk_first_check(input, rv);

		if (rv != libguess_d.encoding.libguess_encoding.undefined) {
			return rv;
		}

		for (size_t i = 0; i < input.length; i++) {
			ubyte c = cast(ubyte)(input[i]);

			/* special treatment of iso-2022 escape sequence */
			if (c == 0x1B) {
				if (i < input.length - 1) {
					c = cast(ubyte)(input[++i]);

					if ((c == '$') || (c == '(')) {
						return libguess_d.encoding.libguess_encoding.ISO_2022_TW;
					}
				}
			}

			rv = libguess_d.dfa.dfa_process(tw_order, c);

			if (rv != libguess_d.encoding.libguess_encoding.undefined) {
				return rv;
			}

			if (libguess_d.dfa.dfa_none(tw_order)) {
				/* we ran out the possibilities */
				return libguess_d.encoding.libguess_encoding.undefined;
			}
		}

		rv = libguess_d.dfa.dfa_top(tw_order);

		return (rv != libguess_d.encoding.libguess_encoding.undefined) ? (rv) : (libguess_d.encoding.libguess_encoding.undefined);
	}

/**
 * Inferring character encoding from a Chinese string
 *
 * Params:
 *      input = input string
 *
 * Returns: Character encoding or null
 */
pure nothrow @trusted @nogc
public libguess_d.encoding.libguess_encoding guess_cn(const char[] input)

	in
	{
	}

	do
	{
		static import libguess_d.dfa;
		static import libguess_d.encoding;

		if (input.length == 0) {
			return libguess_d.encoding.libguess_encoding.undefined;
		}

		libguess_d.dfa.guess_dfa[3] cn_order = [libguess_d.encoding.utf8, libguess_d.encoding.gb2312, libguess_d.encoding.gb18030];
		libguess_d.encoding.libguess_encoding rv = libguess_d.encoding.libguess_encoding.undefined;

		.cjk_first_check(input, rv);

		if (rv != libguess_d.encoding.libguess_encoding.undefined) {
			return rv;
		}

		for (size_t i = 0; i < input.length; i++) {
			ubyte c = cast(ubyte)(input[i]);
			ubyte c2;

			/* special treatment of iso-2022 escape sequence */
			if (c == 0x1B) {
				if (i < input.length - 1) {
					c = cast(ubyte)(input[i + 1]);
					c2 = cast(ubyte)(input[i + 2]);

					if ((c == '$') && ((c2 == ')') || (c2 == '+'))) {
						return libguess_d.encoding.libguess_encoding.ISO_2022_CN;
					}
				}
			}

			rv = libguess_d.dfa.dfa_process(cn_order, c);

			if (rv != libguess_d.encoding.libguess_encoding.undefined) {
				return rv;
			}

			if (libguess_d.dfa.dfa_none(cn_order)) {
				/* we ran out the possibilities */
				return libguess_d.encoding.libguess_encoding.undefined;
			}
		}

		rv = libguess_d.dfa.dfa_top(cn_order);

		return (rv != libguess_d.encoding.libguess_encoding.undefined) ? (rv) : (libguess_d.encoding.libguess_encoding.undefined);
	}

/**
 * Inferring character encoding from a Korean string
 *
 * Params:
 *      input = input string
 *
 * Returns: Character encoding or null
 */
pure nothrow @trusted @nogc
public libguess_d.encoding.libguess_encoding guess_kr(const char[] input)

	in
	{
	}

	do
	{
		static import libguess_d.dfa;
		static import libguess_d.encoding;

		if (input.length == 0) {
			return libguess_d.encoding.libguess_encoding.undefined;
		}

		libguess_d.dfa.guess_dfa[3] kr_order = [libguess_d.encoding.utf8, libguess_d.encoding.euckr, libguess_d.encoding.johab];
		libguess_d.encoding.libguess_encoding rv = libguess_d.encoding.libguess_encoding.undefined;

		.cjk_first_check(input, rv);

		if (rv != libguess_d.encoding.libguess_encoding.undefined) {
			return rv;
		}

		for (size_t i = 0; i < input.length; i++) {
			ubyte c = cast(ubyte)(input[i]);
			ubyte c2;

			/* special treatment of iso-2022 escape sequence */
			if (c == 0x1B) {
				if (i < input.length - 1) {
					c = cast(ubyte)(input[i + 1]);
					c2 = cast(ubyte)(input[i + 2]);

					if ((c == '$') && (c2 == ')')) {
						return libguess_d.encoding.libguess_encoding.ISO_2022_KR;
					}
				}
			}

			rv = libguess_d.dfa.dfa_process(kr_order, c);

			if (rv != libguess_d.encoding.libguess_encoding.undefined) {
				return rv;
			}

			if (libguess_d.dfa.dfa_none(kr_order)) {
				/* we ran out the possibilities */
				return libguess_d.encoding.libguess_encoding.undefined;
			}
		}

		rv = libguess_d.dfa.dfa_top(kr_order);

		return (rv != libguess_d.encoding.libguess_encoding.undefined) ? (rv) : (libguess_d.encoding.libguess_encoding.undefined);
	}
