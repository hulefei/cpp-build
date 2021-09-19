// main_cpp.cpp
#include <stdio.h>

extern "C" int max(int,int);

int main(void){
	int i = max(11,12);
	printf("max value:%d", i);
  	return 0;
}