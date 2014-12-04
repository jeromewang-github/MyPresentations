#
#
# Make file for compiling HMM code in this directory.
# Author: Tapas Kanungo
# Date: 23 February 1998
# $Id: Makefile,v 1.3 1998/02/23 08:12:35 kanungo Exp kanungo $
# 
#
CFLAGS= -g
INCS=
# use the following line to "Purify" the code
#CC=purify gcc
CC=gcc
SRCS=baumwelch.c viterbi.c forward.c backward.c hmmutils.c sequence.c \
	genseq.c nrutil.c testvit.c esthmm.c 
all: genseq testvit esthmm      
genseq: genseq.o sequence.o nrutil.o hmmutils.o 
	 $(CC) -o genseq genseq.o sequence.o nrutil.o hmmutils.o  -lm
testvit: testvit.o viterbi.o nrutil.o hmmutils.o sequence.o
	 $(CC) -o testvit testvit.o viterbi.o nrutil.o sequence.o hmmutils.o -lm
esthmm: esthmm.o baumwelch.o nrutil.o hmmutils.o sequence.o \
		forward.o backward.o
	 $(CC) -o esthmm esthmm.o baumwelch.o nrutil.o sequence.o hmmutils.o \
		forward.o backward.o -lm
shar:
	shar *.c *.h Makefile README TODO COPYING *.seq *.hmm
depend:
	makedepend -- $(INCS) -- $(SRCS) 
clean:
	rm *.o a.out 
# DO NOT DELETE THIS LINE -- make depend depends on it.

baumwelch.o: /usr/include/stdio.h /usr/include/sys/feature_tests.h nrutil.h
baumwelch.o: hmm.h
viterbi.o: /usr/include/math.h hmm.h nrutil.h
forward.o: /usr/include/stdio.h /usr/include/sys/feature_tests.h hmm.h
backward.o: /usr/include/stdio.h /usr/include/sys/feature_tests.h hmm.h
hmmutils.o: /usr/include/stdio.h /usr/include/sys/feature_tests.h
hmmutils.o: /usr/include/stdlib.h /usr/include/math.h nrutil.h hmm.h
sequence.o: /usr/include/stdio.h /usr/include/sys/feature_tests.h
sequence.o: /usr/include/stdlib.h /usr/include/math.h /usr/include/string.h
sequence.o: nrutil.h hmm.h
genseq.o: /usr/include/stdio.h /usr/include/sys/feature_tests.h
genseq.o: /usr/include/stdlib.h /usr/include/math.h /usr/include/string.h
genseq.o: nrutil.h hmm.h
nrutil.o: /usr/include/malloc.h /usr/include/stdio.h
nrutil.o: /usr/include/sys/feature_tests.h
testvit.o: /usr/include/stdio.h /usr/include/sys/feature_tests.h
testvit.o: /usr/include/stdlib.h /usr/include/math.h /usr/include/string.h
testvit.o: nrutil.h hmm.h
esthmm.o: /usr/include/stdio.h /usr/include/sys/feature_tests.h
esthmm.o: /usr/include/stdlib.h /usr/include/math.h /usr/include/string.h
esthmm.o: nrutil.h hmm.h
