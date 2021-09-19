@echo off

gcc -E main_c.c -o main_c.i
gcc -S main_c.i -o main_c.s
gcc -c main_c.s -o main_c.o

gcc -E max_c.c -o max_c.i
gcc -S max_c.i -o max_c.s
gcc -c max_c.s -o max_c.o 


gcc main_c.o max_c.o -o main_c.exe

echo "========"
nm main_c.o
echo "========"
nm max_c.o