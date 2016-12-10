#!/bin/bash

nasm -f elf32 -D ELF_TYPE interval_impl.asm
gcc -m32 -w test_suite.c interval_impl.o
./a.out
rm a.out
rm *.o
