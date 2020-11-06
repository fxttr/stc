CC=clang

WARN= -Wall -Wextra -Wno-unused-parameter -Wno-deprecated-declarations -Wformat-security -Wformat -Werror=format-security -Wstack-protector
SEC= -march=native -fstack-protector-all --param ssp-buffer-size=4 -fpie -ftrapv -D_FORTIFY_SOURCE=2

CFLAGS= ${SEC} ${WARN} -std=c99 -pedantic -D_XOPEN_SOURCE=600 -Wvariadic-macros -O2 -I/usr/X11R6/include -I/usr/X11R6/include/freetype2
LDFLAGS= -L/usr/X11R6/lib -lc -lm -lX11 -lutil -lXft -lXrender -lfontconfig -Wl,-z,relro,-z,now -pie

SRC = src/stc.c
OBJECT = stc.o

all: _stc_
	@echo CC -o $@
	@${CC} ${OBJECT} -o stc ${LDFLAGS}

_stc_:
	@echo CC ${SRC}
	@${CC} -c ${CFLAGS} ${SRC}

.PHONY: clean install uninstall

clean:
	@echo cleaning
	@rm -rf stc *.o *~

install: all
	@echo installing executable file to /usr/local/bin
	@mkdir -p /usr/local/bin
	@cp -f stc /usr/local/bin
	@chmod 755 /usr/local/bin/stc

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/stc
