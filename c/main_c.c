// main_c.c
#include <stdio.h>

extern int max(int,int);

int main(void){
	int i = max(11,12);
	printf("max value:%d", i);
  	return 0;
}