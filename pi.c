static long num_rects = 1000000000000;
static double area
void main()
{
	pthread_t thread1, thread2;
	int i;
	double mid, height, width, sum = 0.0;
	double area;
	width = 1.0/(double) num_rects;
	for (i = 0; i < num_rects; i++){
		mid = (i + 0.5) * width;
		height = 4.0/(1.0 + mid*mid);
		sum += height;
	}
	area = width * sum;
	printf("Computed pi = %f\n", area);
}
	
void * calculate(i)
{
	int i;
	double mid, height, width, sum = 0.0;
	double area;
	width = 1.0/(double) num_rects;
	for (i = 0; i < num_rects; i++){
		mid = (i + 0.5) * width;
		height = 4.0/(1.0 + mid*mid);
		sum += height;
	}
	area = width * sum;
}
