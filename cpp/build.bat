@echo off

g++ -E main_cpp.cpp -o main_cpp.i
g++ -S main_cpp.i -o main_cpp.s
g++ -c main_cpp.s -o main_cpp.o

g++ -E max_cpp.cpp -o max_cpp.i
g++ -S max_cpp.i -o max_cpp.s
g++ -c max_cpp.s -o max_cpp.o 


g++ main_cpp.o max_cpp.o -o max_cpp.exe

echo "========"
nm main_cpp.o
echo "========"
nm max_cpp.o