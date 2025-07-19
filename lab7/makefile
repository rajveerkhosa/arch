CC=gcc
FLAGS=-Wall -O0

all: a.out faxpySIMD4.out faxpySIMD2.out

a.out: faxpy.o test_faxpy.o
	gcc -Wall -O0 $^ -o $@

faxpy.o: faxpy.s
	gcc -Wall -O0 -c $< -o $@

faxpySIMD4.out: faxpySIMD4.o test_faxpy.o
	gcc -Wall -O0 $^ -o $@

faxpySIMD4.o: faxpySIMD4.s
	gcc -Wall -O0 -c $< -o $@

faxpySIMD2.out: faxpySIMD2.o test_faxpy.o
	gcc -Wall -O0 $^ -o $@

faxpySIMD2.o: faxpySIMD2.s
	gcc -Wall -O0 -c $< -o $@

test_faxpy.o: test_faxpy.c
	gcc -Wall -O0 -c $< -o $@

clean:
	rm -f *.o *.out

