# Unix makefile for JBIG-KIT
# $Id: Makefile 1303 2008-08-30 20:16:20Z mgk25 $

# Select an ANSI/ISO C compiler here, GNU gcc is recommended
CC = gcc

# Options for the compiler: A high optimization level is suggested
CCFLAGS = -O2 -W
#CCFLAGS = -O -g -W -Wall -ansi -pedantic #-DDEBUG  # developer only

CFLAGS = $(CCFLAGS) -I../libjbig

VERSION=2.0

all: lib pbm
	@echo "Enter 'make test' in order to start some automatic tests."

lib:
	(cd libjbig;  make "CC=$(CC)" "CFLAGS=$(CFLAGS)")

pbm: lib
	(cd pbmtools; make "CC=$(CC)" "CFLAGS=$(CFLAGS)")

test: lib pbm
	(cd libjbig;  make "CC=$(CC)" "CFLAGS=$(CFLAGS)" test)
	(cd pbmtools; make "CC=$(CC)" "CFLAGS=$(CFLAGS)" test)

clean:
	rm -f *~ core
	(cd libjbig; make clean)
	(cd pbmtools; make clean)

distribution: clean
	rm -f libjbig/libjbig*.a
	(cd ..; tar -c -v --exclude .svn -f jbigkit-$(VERSION).tar jbigkit ; \
	  gzip -9f jbigkit-$(VERSION).tar )
	scp ../jbigkit-$(VERSION).tar.gz slogin-serv1.cl.cam.ac.uk:public_html/download/
	scp CHANGES slogin-serv1.cl.cam.ac.uk:public_html/jbigkit/
