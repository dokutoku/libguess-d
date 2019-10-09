/**
 * 
 *
 * License: BSD 3-clause
 */
module libguess_d.encoding;


private static import libguess_d.dfa;
private static import libguess_d.guess.table.common_table;

static import libguess_d.dfa;

public:

/**
 *
 */
enum libguess_encoding
{
	undefined,
	BIG5,
	CP1251,
	CP1253,
	CP1254,
	CP1255,
	CP1256,
	CP866,
	EUC_JP,
	EUC_KR,
	GB2312,
	GB18030,
	ISO_2022_CN,
	ISO_2022_JP,
	ISO_2022_KR,
	ISO_2022_TW,
	ISO_8859_6,
	ISO_8859_7,
	ISO_8859_8_I,
	ISO_8859_9,
	JOHAB,
	KOI8_R,
	SJIS,
	UCS_2BE,
	UCS_2LE,
	UTF_8,
	UTF_16,
	UTF_32,
}

/**
 *
 */
enum supported_lang
{
	ar,
	cn,
	gr,
	hw,
	ja,
	kr,
	ru,
	tr,
	tw,
}

/**
 * 
 *
 * Params:
 *      input = input encoding
 *
 * Returns: Character encoding or null
 */
pure nothrow @safe @nogc
string encoding_name(bool WITH_G_CONVERT = false)(.libguess_encoding input_encoding)

	do
	{
		switch (input_encoding) {
			case .libguess_encoding.UTF_8:
				return `UTF-8`;

			static if (WITH_G_CONVERT) {
				case .libguess_encoding.UCS_2BE:
				case .libguess_encoding.UCS_2LE:
				case .libguess_encoding.UTF_16:
					return `UTF-16`;
			} else {
				case .libguess_encoding.UTF_16:
					return `UTF-16`;

				case .libguess_encoding.UCS_2BE:
					return `UCS-2BE`;

				case .libguess_encoding.UCS_2LE:
					return `UCS-2LE`;
			}

			case .libguess_encoding.UTF_32:
				return `UTF-32`;

			case .libguess_encoding.BIG5:
				return `BIG5`;

			case .libguess_encoding.CP1251:
				return `CP1251`;

			case .libguess_encoding.CP1253:
				return `CP1253`;

			case .libguess_encoding.CP1254:
				return `CP1254`;

			case .libguess_encoding.CP1255:
				return `CP1255`;

			case .libguess_encoding.CP1256:
				return `CP1256`;

			case .libguess_encoding.CP866:
				return `CP866`;

			case .libguess_encoding.EUC_JP:
				return `EUC-JP`;

			case .libguess_encoding.EUC_KR:
				return `EUC-KR`;

			case .libguess_encoding.GB18030:
				return `GB18030`;

			case .libguess_encoding.GB2312:
				return `GB2312`;

			case .libguess_encoding.ISO_2022_CN:
				return `ISO-2022-CN`;

			case .libguess_encoding.ISO_2022_JP:
				return `ISO-2022-JP`;

			case .libguess_encoding.ISO_2022_KR:
				return `ISO-2022-KR`;

			case .libguess_encoding.ISO_2022_TW:
				return `ISO-2022-TW`;

			case .libguess_encoding.ISO_8859_6:
				return `ISO-8859-6`;

			case .libguess_encoding.ISO_8859_7:
				return `ISO-8859-7`;

			case .libguess_encoding.ISO_8859_8_I:
				return `ISO-8859-8-I`;

			case .libguess_encoding.ISO_8859_9:
				return `ISO-8859-9`;

			case .libguess_encoding.JOHAB:
				return `JOHAB`;

			case .libguess_encoding.KOI8_R:
				return `KOI8-R`;

			case .libguess_encoding.SJIS:
				return `SJIS`;

			default:
				return null;
		}
	}

static immutable libguess_d.dfa.guess_dfa eucjp = libguess_d.dfa.guess_dfa(&libguess_d.guess.table.common_table.guess_eucj_st, &libguess_d.guess.table.common_table.guess_eucj_ar, .libguess_encoding.EUC_JP);
static immutable libguess_d.dfa.guess_dfa big5 = libguess_d.dfa.guess_dfa(&libguess_d.guess.table.common_table.guess_big5_st, &libguess_d.guess.table.common_table.guess_big5_ar, .libguess_encoding.BIG5);
static immutable libguess_d.dfa.guess_dfa cp1253 = libguess_d.dfa.guess_dfa(&libguess_d.guess.table.common_table.guess_cp1253_st, &libguess_d.guess.table.common_table.guess_cp1253_ar, .libguess_encoding.CP1253);
static immutable libguess_d.dfa.guess_dfa cp1254 = libguess_d.dfa.guess_dfa(&libguess_d.guess.table.common_table.guess_cp1253_st, &libguess_d.guess.table.common_table.guess_cp1253_ar, .libguess_encoding.CP1254);
static immutable libguess_d.dfa.guess_dfa cp1255 = libguess_d.dfa.guess_dfa(&libguess_d.guess.table.common_table.guess_cp1255_st, &libguess_d.guess.table.common_table.guess_cp1255_ar, .libguess_encoding.CP1255);
static immutable libguess_d.dfa.guess_dfa cp1256 = libguess_d.dfa.guess_dfa(&libguess_d.guess.table.common_table.guess_cp1256_st, &libguess_d.guess.table.common_table.guess_cp1256_ar, .libguess_encoding.CP1256);
static immutable libguess_d.dfa.guess_dfa euckr = libguess_d.dfa.guess_dfa(&libguess_d.guess.table.common_table.guess_euck_st, &libguess_d.guess.table.common_table.guess_euck_ar, .libguess_encoding.EUC_KR);
static immutable libguess_d.dfa.guess_dfa gb2312 = libguess_d.dfa.guess_dfa(&libguess_d.guess.table.common_table.guess_gb2312_st, &libguess_d.guess.table.common_table.guess_gb2312_ar, .libguess_encoding.GB2312);
static immutable libguess_d.dfa.guess_dfa gb18030 = libguess_d.dfa.guess_dfa(&libguess_d.guess.table.common_table.guess_gb18030_st, &libguess_d.guess.table.common_table.guess_gb18030_ar, .libguess_encoding.GB18030);
static immutable libguess_d.dfa.guess_dfa iso8859_6 = libguess_d.dfa.guess_dfa(&libguess_d.guess.table.common_table.guess_iso8859_6_st, &libguess_d.guess.table.common_table.guess_iso8859_6_ar, .libguess_encoding.ISO_8859_6);
static immutable libguess_d.dfa.guess_dfa iso8859_7 = libguess_d.dfa.guess_dfa(&libguess_d.guess.table.common_table.guess_iso8859_7_st, &libguess_d.guess.table.common_table.guess_iso8859_7_ar, .libguess_encoding.ISO_8859_7);
static immutable libguess_d.dfa.guess_dfa iso8859_8 = libguess_d.dfa.guess_dfa(&libguess_d.guess.table.common_table.guess_iso8859_8_st, &libguess_d.guess.table.common_table.guess_iso8859_8_ar, .libguess_encoding.ISO_8859_8_I);
static immutable libguess_d.dfa.guess_dfa iso8859_9 = libguess_d.dfa.guess_dfa(&libguess_d.guess.table.common_table.guess_iso8859_9_st, &libguess_d.guess.table.common_table.guess_iso8859_9_ar, .libguess_encoding.ISO_8859_9);
static immutable libguess_d.dfa.guess_dfa johab = libguess_d.dfa.guess_dfa(&libguess_d.guess.table.common_table.guess_johab_st, &libguess_d.guess.table.common_table.guess_johab_ar, .libguess_encoding.JOHAB);
static immutable libguess_d.dfa.guess_dfa sjis = libguess_d.dfa.guess_dfa(&libguess_d.guess.table.common_table.guess_sjis_st, &libguess_d.guess.table.common_table.guess_sjis_ar, .libguess_encoding.SJIS);
static immutable libguess_d.dfa.guess_dfa utf8 = libguess_d.dfa.guess_dfa(&libguess_d.guess.table.common_table.guess_utf8_st, &libguess_d.guess.table.common_table.guess_utf8_ar, .libguess_encoding.UTF_8);
