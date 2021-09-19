@echo off

g++ -E main_cpp.cpp -o main_cpp.i
g++ -S main_cpp.i -o main_cpp.s
g++ -c main_cpp.s -o main_cpp.o

gcc -E max_c.c -o max_c.i
gcc -S max_c.i -o max_c.s
gcc -c max_c.s -o max_c.o 

 
g++ main_cpp.o max_c.o -o main_cpp.exe

echo "main_cpp========"
nm main_cpp.o
echo "main_cpp========"
nm max_c.o