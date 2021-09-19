# gcc build and load

## C build and link
```c
// main_c.c
#include <stdio.h>

extern int max(int,int);

int main(void){
	int i = max(11,12);
	printf("max value:%d", i);
  	return 0;
}
```

```c
//max_c.c
int max(int x, int y){
  return x >= y ? x : y;
}
```

```
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
```


```
"main_c.c ========"
0000000000000000 b .bss
0000000000000000 d .data
0000000000000000 p .pdata
0000000000000000 r .rdata
0000000000000000 r .rdata$zzz
0000000000000000 t .text
0000000000000000 r .xdata
                 U __main
0000000000000000 T main //包含代码
                 U max  //只包含符号
                 U printf
"max_c.c========"
0000000000000000 b .bss
0000000000000000 d .data
0000000000000000 p .pdata
0000000000000000 r .rdata$zzz
0000000000000000 t .text
0000000000000000 r .xdata
0000000000000000 T max  //包含代码
```

### 总结

函数符号类型:
* T 该符号放在当前目标文件的代码段中，通常是那些全局非 static 函数
* U 该符号在当前目标文件中未定义，需要从其他对象文件中链接进来

## cpp load and link

```cpp
// main_cpp.cpp
#include <stdio.h>

extern int max(int,int);

int main(void){
	int i = max(11,12);
	printf("max value:%d", i);
  	return 0;
}
```

```cpp
//max_cpp.cpp
int max(int x, int y){
  return x >= y ? x : y;
}
```

```
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
```

```
"========"
0000000000000000 b .bss
0000000000000000 d .data
0000000000000000 p .pdata
0000000000000000 r .rdata
0000000000000000 r .rdata$zzz
0000000000000000 t .text
0000000000000000 r .xdata
                 U __main
                 U _Z3maxii
0000000000000000 T main
                 U printf
"========"
0000000000000000 b .bss
0000000000000000 d .data
0000000000000000 p .pdata
0000000000000000 r .rdata$zzz
0000000000000000 t .text
0000000000000000 r .xdata
0000000000000000 T _Z3maxii
```

### 总结
* cpp的编辑器 符号表带有参数类型_Z3maxii


### cpp 调用 cpp 函数

```cpp
// main_cpp.cpp
#include <stdio.h>
#include "max.h"

// extern int max(int,int);

int main(void){
	int i = max(11,13);
	printf("max value:%d", i);
  	return 0;
}
```

```cpp
//max_cpp.cpp
int max(int x, int y){
  return x >= y ? x : y;
}
```


```
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
```


```
"main_cpp========"
0000000000000000 b .bss
0000000000000000 d .data
0000000000000000 p .pdata
0000000000000000 r .rdata
0000000000000000 r .rdata$zzz
0000000000000000 t .text
0000000000000000 r .xdata
                 U __main
                 U _Z3maxii
0000000000000000 T main
                 U printf
"max_cpp========"
0000000000000000 b .bss
0000000000000000 d .data
0000000000000000 p .pdata
0000000000000000 r .rdata$zzz
0000000000000000 t .text
0000000000000000 r .xdata
0000000000000000 T _Z3maxii
```

### cpp中调用c函数使用 extern "C"


```cpp
// main_cpp.cpp
#include <stdio.h>

extern "C" int max(int,int);

int main(void){
	int i = max(11,12);
	printf("max value:%d", i);
  	return 0;
}
```

```c
//max_c.c
int max(int x, int y){
  return x >= y ? x : y;
}
```

```
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
```


```
"main_cpp========"
0000000000000000 b .bss
0000000000000000 d .data
0000000000000000 p .pdata
0000000000000000 r .rdata
0000000000000000 r .rdata$zzz
0000000000000000 t .text
0000000000000000 r .xdata
                 U __main
0000000000000000 T main
                 U max
                 U printf
"main_cpp========"
0000000000000000 b .bss
0000000000000000 d .data
0000000000000000 p .pdata
0000000000000000 r .rdata$zzz
0000000000000000 t .text
0000000000000000 r .xdata
0000000000000000 T max
```


### c中调用cpp


```c
// main2_c.c
#include <stdio.h>

//直接使用cpp的标识符
extern int maxii(int,int);

int main(void){
	//直接使用cpp的标识符
	int i = maxii(11,12);
	printf("max value:%d", i);
  	return 0;
}
```

```cpp
//max_cpp.cpp
int max(int x, int y){
  return x >= y ? x : y;
}

// extern C call
extern "C" {
  int maxii(int x,int y){
    return max(x,y);
  }
}
```


```
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
```


```
"max_cpp========"
0000000000000000 b .bss
0000000000000000 d .data
0000000000000000 p .pdata
0000000000000000 r .rdata$zzz
0000000000000000 t .text
0000000000000000 r .xdata
0000000000000000 T _Z3maxii //c++函数
000000000000001c T maxii //c函数，在c函数中调用了c++函数
"main2_c========"
0000000000000000 b .bss
0000000000000000 d .data
0000000000000000 p .pdata
0000000000000000 r .rdata
0000000000000000 r .rdata$zzz
0000000000000000 t .text
0000000000000000 r .xdata
                 U __main
0000000000000000 T main
                 U maxii
                 U printf
```

#### 外部参考

[为什么需要 extern "C"?](https://imzlp.com/posts/5392/)



