#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <assert.h>

void print_line(int n)
{
	char buf[32];
	snprintf(buf, sizeof(buf), "Line #%d\n", n);
	write(1, buf, strlen(buf));
}

int main()
{
	int fd;
	print_line(1);
	print_line(2);
	print_line(3);

	fd=open("junk.out", O_WRONLY|O_CREAT, 0666);
	assert(fd>=0);
	dup2(fd,1);
	
	
	print_line(4);
	print_line(5);
	print_line(6);

	close(fd);
	close(1);
}

