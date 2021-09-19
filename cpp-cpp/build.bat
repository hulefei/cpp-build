@echo off

g++ -E max_cpp.cpp -o max_cpp.i
g++ -S max_cpp.i -o max_cpp.s
g++ -c max_cpp.s -o max_cpp.o

g++ -E main_cpp.cpp -o main_cpp.i
rem 编译成汇编代码
g++ -S main_cpp.i -o main_cpp.s
rem 从汇编代码生成目标文件
g++ -c main_cpp.s -o main_cpp.o
rem 直接从源文件生成目标文件
g++ -c main_cpp.o

g++ main_cpp.o max_cpp.o -o main_cpp.exe

echo "main_cpp========"
nm main_cpp.o
echo "max_cpp========"
nm max_cpp.o