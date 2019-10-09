/*
 * This code is derivative of guess.c of Gauche-0.8.3.
 * The following is the original copyright notice.
 */

/*
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
module libguess_d.dfa;


private static import libguess_d.encoding;

/**
 * data types
 */
package struct guess_arc
{
public:
	/**
	 * next state
	 */
	byte next;

	/**
	 * score
	 */
	double score;

	invariant
	{
		assert(this.next >= 0);
	}
}

/**
 *
 */
package struct guess_dfa
{
	static import libguess_d.encoding;

private:
	/**
	 *
	 */
	immutable byte[][256]* states;

	/**
	 *
	 */
	immutable .guess_arc[]* arcs;

	/**
	 *
	 */
	byte state = 0;

	/**
	 *
	 */
	immutable libguess_d.encoding.libguess_encoding name;

public:
	/**
	 *
	 */
	double score = 1.0;

	/**
	 * init data
	 *
	 * Params:
	 *      st = guess_*_st pointer
	 *      ar = guess_*_ar pointer
	 */
	pragma(inline, true)
	pure nothrow @safe @nogc
	this(immutable byte[][256]* st, immutable .guess_arc[]* ar, const libguess_d.encoding.libguess_encoding name)

		do
		{
			this.states = st;
			this.arcs = ar;
			this.name = name;
		}

	/**
	 * check whether this.state is available
	 */
	pragma(inline, true)
	pure nothrow @safe @nogc
	bool is_alive() const

		do
		{
			return this.state >= 0;
		}

	/**
	 * 
	 *
	 * Params:
	 *      ch = 
	 */
	pure nothrow @safe @nogc
	bool is_alone(S)(const ref S order) const
	{
		if (this.state < 0) {
			return false;
		}

		for (size_t i = 0; i < order.length; i++) {
			if (order[i].is_alive()) {
				return false;
			}
		}

		return true;
	}

	/**
	 * 
	 *
	 * Params:
	 *      ch = character to keep the score
	 */
	pure nothrow @trusted @nogc
	void next(const ubyte ch)

		do
		{
			if (this.is_alive()) {
				immutable byte arc__ = (*this.states)[this.state][ch];

				if (arc__ < 0) {
					this.state = -1;
				} else {
					this.state = (*this.arcs)[cast(size_t)(arc__)].next;
					this.score *= (*this.arcs)[cast(size_t)(arc__)].score;
				}
			}
		}

	invariant
	{
	}
}


/**
 * 
 *
 * Params:
 *      order = 
 */
pure nothrow @safe @nogc
bool dfa_none(S)(const ref S order)

	do
	{
		for (size_t i = 0; i < order.length; i++) {
			if (order[i].is_alive()) {
				return false;
			}
		}

		return true;
	}

/**
 * 
 *
 * Params:
 *      order = 
 */
pure nothrow @safe @nogc
libguess_d.encoding.libguess_encoding dfa_top(S)(const ref S order)

	do
	{
		static import libguess_d.encoding;

		const (guess_dfa)* top = null;

		for (size_t i = 0; i < order.length; i++) {
			if (order[i].is_alive()) {
				if ((top == null) || (order[i].score > top.score)) {
					top = &order[i];
				}
			}
		}

		if (top != null) {
			return (*top).name;
		} else {
			return libguess_d.encoding.libguess_encoding.undefined;
		}
	}

/**
 * 
 *
 * Params:
 *      input = 
 */
pure nothrow @safe @nogc
libguess_d.encoding.libguess_encoding check_UTF16_BOM(const char[] input)

	do
	{
		static import libguess_d.encoding;

		/* special treatment of BOM */
		if (input.length > 1) {
			if ((input[0] == 0xFF) && (input[1] == 0xFE)) {
				return libguess_d.encoding.libguess_encoding.UCS_2LE;
			} else if ((input[0] == 0xFE) && (input[1] == 0xFF)) {
				return libguess_d.encoding.libguess_encoding.UCS_2BE;
			}
		}

		return libguess_d.encoding.libguess_encoding.undefined;
	}

/**
 * 
 *
 * Params:
 *      order = 
 *      c = 
 */
pure nothrow @trusted @nogc
libguess_d.encoding.libguess_encoding dfa_process(S)(ref S order, const ubyte c)

	do
	{
		static import libguess_d.encoding;

		for (size_t i = 0; i < order.length; i++) {
			if (order[i].is_alive()) {
				if (order[i].is_alone(order)) {
					return order[i].name;
				}

				order[i].next(c);
			}
		}

		return libguess_d.encoding.libguess_encoding.undefined;
	}
