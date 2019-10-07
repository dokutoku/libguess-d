#ifndef _LIBGUESS_H
#define _LIBGUESS_H	1

#include <stdlib.h>
#include <string.h>

/* prototypes */
const char *guess_jp(const char *buf, int buflen);
const char *guess_tw(const char *buf, int buflen);
const char *guess_cn(const char *buf, int buflen);
const char *guess_kr(const char *buf, int buflen);
const char *guess_ru(const char *buf, int buflen);
const char *guess_ar(const char *buf, int buflen);
const char *guess_tr(const char *buf, int buflen);
const char *guess_gr(const char *buf, int buflen);
const char *guess_hw(const char *buf, int buflen);
int dfa_validate_utf8(const char *buf, int buflen);

#define GUESS_REGION_JP		"japanese"
#define GUESS_REGION_TW		"taiwanese"
#define GUESS_REGION_CN		"chinese"
#define GUESS_REGION_KR		"korean"
#define GUESS_REGION_RU		"russian"
#define GUESS_REGION_AR		"arabic"
#define GUESS_REGION_TR		"turkish"
#define GUESS_REGION_GR		"greek"
#define GUESS_REGION_HW		"hebrew"

const char *guess_encoding(const char *buf, int buflen, const char *lang);

#endif
