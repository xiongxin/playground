#include <sys/syscall.h>

typedef unsigned long size_t;

int my_errno;

int
my_write(int fd, const void *buf, size_t len)
{
  int ret;
  asm volatile ("pushl %%ebx\n"      // older gcc before version 5
		"\tmovl %2,%%ebx\n"  // won't allow direct use of
		"\tint $0x80\n"      // %ebx in PIC code
		"\tpopl %%ebx"
		: "=a" (ret)
		: "0" (SYS_write), "g" (fd), "c" (buf), "d" (len) : "memory");
  if (ret < 0) {
    my_errno = -ret;
    return -1;
  }
  return ret;
}

