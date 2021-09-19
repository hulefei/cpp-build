@echo off

gcc -E main_c.c -o main_c.i
gcc -S main_c.i -o main_c.s
gcc -c main_c.s -o main_c.o

gcc -E main2_c.c -o main2_c.i
gcc -S main2_c.i -o main2_c.s
gcc -c main2_c.s -o main2_c.o

g++ -E max_cpp.cpp -o max_cpp.i
g++ -S max_cpp.i -o max_cpp.s
g++ -c max_cpp.s -o max_cpp.o 

gcc main_c.o max_cpp.o -o main_c.exe
gcc main2_c.o max_cpp.o -o main2_c.exe

echo "main_c========"
nm main_c.o

echo "max_cpp========"
nm max_cpp.o

echo "main2_c========"
nm main2_c.o

@REM echo "main_c.exe"
@REM main_c.exe

@REM echo "main2_c.exe"
@REM main2_c.exe