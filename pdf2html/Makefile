CC = gcc
CFLAGS = -O3 -Wall -funroll-loops -s
LDLIBS = -lpng
PROGRAMS = pbm2png pbm2eps9

all: $(PROGRAMS)

pbm2png: pbm2png.c
	$(CC) $(CFLAGS) -o pbm2png pbm2png.c $(LDLIBS)

pbm2eps9: pbm2eps9.o printer.o
	$(CC) -s -o pbm2eps9 pbm2eps9.o printer.o

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f $(PROGRAMS) *.o *~

.PHONY: all clean

pbm2eps9.o: pbm2eps9.c printer.h
printer.o: printer.c
