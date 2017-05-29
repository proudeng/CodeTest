#include <stdio.h>
#include <time.h>
#include <stdlib.h>

int main() {
	time_t timep;
	time (&timep);
	printf("time before calculation1: %s\n", asctime(gmtime(&timep)));
	int arr[64 * 1024];
	for (int i = 0; i < 64 * 1024; i++)
		arr[i] *=3;
	
	time(&timep);
	printf("time after calculation1: %s\n", asctime(gmtime(&timep)));

	time (&timep);
	printf("time before calculation2: %s\n", asctime(gmtime(&timep)));
	for (int i = 0; i < 64 * 1024; i +=16)
		arr[i] *=3;
	
	time(&timep);
	printf("time after calculation2: %s\n", asctime(gmtime(&timep)));
	return 0;
}

