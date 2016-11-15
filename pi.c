#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <pthread.h>


static long num_rects = 10000000000;
double area =0;
pthread_mutex_t mutex1 = PTHREAD_MUTEX_INITIALIZER;

void *calculate1()
{

    int i;
    double mid, height, width, sum = 0.0;
    width = 1.0/(double) num_rects;
    for (i = 0; i < 0.5*num_rects; i++){
        mid = (i + 0.5) * width;
        height = 4.0/(1.0 + mid*mid);
        sum += height;
    }
    pthread_mutex_lock(&mutex1);
    area += width * sum;
    pthread_mutex_unlock(&mutex1);

    printf("calculate1: %f\n", area);		
	
}

void *calculate2()
{

    int i;
    double mid, height, width, sum = 0.0;
    width = 1.0/(double) num_rects;
    for (i = 0.5*num_rects; i < num_rects; i++){
        mid = (i + 0.5) * width;
        height = 4.0/(1.0 + mid*mid);
        sum += height;
    }
    pthread_mutex_lock(&mutex1);
    area += width * sum;
    pthread_mutex_unlock(&mutex1);

    printf("calculate2: %f\n", area);		
}


void main()
{
	int iret1, iret2;
	pthread_t thread1, thread2;

	time_t timep;
	time (&timep);
	printf("time before calculation: %s\n", asctime(gmtime(&timep)));

	iret1 = pthread_create(&thread1, NULL,calculate1,NULL);
	iret2 = pthread_create(&thread2, NULL,calculate2,NULL);

	pthread_join(thread1, NULL);
	pthread_join(thread2, NULL);

	printf("Computed pi = %f\n", area);
	time(&timep);
	printf("time after calculation: %s\n", asctime(gmtime(&timep)));
	
	exit(EXIT_SUCCESS);
}

