// main_cpp.cpp
#include <stdio.h>
#include "max.h"

// extern int max(int,int);

int main(void){
	int i = max(11,13);
	printf("max value:%d", i);
  	return 0;
}