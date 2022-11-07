
CC = gcc -m32 -no-pie -fno-pic
CFLAGS = -g -O0 -fno-builtin
LIBS = -nodefaultlibs -lc_nonshared

PROGS = hello1 hello2 hello3 hello4

all: hello1.s hello4.s mywrite.s mywrite-pic.s $(PROGS)
.PHONY: all

hello1: hello1.o
	$(CC) -static -o $@ hello1.o $(LIBS)

hello2: hello2.o mywrite.lo
	$(CC) -static -o $@ hello2.o mywrite.o $(LIBS)

mywrite-pic.s: mywrite.c
	$(CC) $(CFLAGS) -fPIC -DPIC -o $@ -S mywrite.c

libmy.la: mywrite.lo mystrlen.lo
	libtool --mode=link $(CC) \
		-o $@ mywrite.lo mystrlen.lo \
		-rpath $(PWD)/dest -Wc,-nostdlib

dest/libmy.la: libmy.la
	mkdir -p $(PWD)/dest
	libtool --mode=install cp libmy.la $(PWD)/dest

hello3: hello3.o
	$(CC) -o $@ hello3.o $(LIBS) -ldl

hello4: hello4.o dest/libmy.la
	libtool --mode=link $(CC) -o $@ hello4.o $(PWD)/dest/libmy.la $(LIBS)

.SUFFIXES: .c .o .s .lo
.c.o:
	$(CC) $(CFLAGS) -c -g $<
.c.s:
	$(CC) $(CFLAGS) -S $<
.c.lo:
	libtool --mode=compile $(CC) $(CFLAGS) -c $<

.PHONY: clean
clean:
	rm -rf .libs dest
	rm -f $$(cat .gitignore)
