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