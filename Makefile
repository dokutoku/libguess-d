PREFIX = /usr/local

MAJOR = 0
MINOR = 3
REVISION = 0
VER = ${MAJOR}.${MINOR}.${REVISION}

CC = gcc
#OBJS = guess.o

SRCS = guess.c		\
       dfa.c		\
       arabic_impl.c	\
       cjk_impl.c	\
       greek_impl.c	\
       hebrew_impl.c	\
       russian_impl.c	\
       turkish_impl.c


#SRCS = ${OBJS:.o=.c} guess_tab.c libguess.h test.c

OBJS = ${SRCS:.c=.o} 

LIBS = libguess.so libguess.a
CFLAGS += -fPIC -pg -g
SONAME = libguess.so.${MAJOR}


all: $(LIBS) test

libguess.so: ${OBJS}
	${CC} -o libguess.so -shared -Wl,-soname,${SONAME} ${OBJS}

libguess.a: ${OBJS}
	ar rc libguess.a ${OBJS}
	ranlib libguess.a

$(OBJS) : $(SRCS) libguess.h guess_tab.c


guess_tab.c : guess.scm
	gosh guess.scm guess_tab.c

test: test.c libguess.a
	gcc -g -o test test.c libguess.a

install:
	install -m644 libguess.h ${PREFIX}/include
	rm -f ${PREFIX}/lib/libguess.*
	install -m755 libguess.so ${PREFIX}/lib/libguess.so.${VER}
	install -m644 libguess.a ${PREFIX}/lib
	ln -sf ${PREFIX}/lib/libguess.so.${VER} ${PREFIX}/lib/libguess.so.${MAJOR}
	ln -sf ${PREFIX}/lib/libguess.so.${MAJOR} ${PREFIX}/lib/libguess.so

clean:
	rm -f $(LIBS) $(OBJS) test

mostlyclean: clean
	rm -f guess_tab.c

distclean: clean
	rm -f *~ core*
