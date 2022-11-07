/* (from glibc sysdeps/unix/sysv/linux/i386/sysdep.h)
   https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/i386/sysdep.h

   Linux takes system call arguments in registers:

        syscall number  %eax         call-clobbered
        arg 1           %ebx         call-saved
        arg 2           %ecx         call-clobbered
        arg 3           %edx         call-clobbered
        arg 4           %esi         call-saved
        arg 5           %edi         call-saved
        arg 6           %ebp         call-saved
*/

#include <sys/syscall.h>

typedef unsigned long size_t;

int my_write(int, const void *, size_t);

int my_errno;

size_t
my_strlen(const char *p)
{
  size_t ret;
  for (ret = 0; p[ret]; ++ret)
    ;
  return ret;
}

int
my_write(int fd, const void *buf, size_t len)
{
  int ret;
  asm volatile ("int $0x80" : "=a" (ret)
		: "0" (SYS_write), "b" (fd), "c" (buf), "d" (len) : "memory");
  if (ret < 0) {
    my_errno = -ret;
    return -1;
  }
  return ret;
}

const char greeting[] = "hello world\n";
int
main(int argc, char **argv, char **envp)
{
  my_write (1, greeting, my_strlen(greeting));
}

void
__libc_start_main(int (*mainp)(int, char **, char **),
		  int argc, char **argv)
{
  mainp(argc, argv, argv + argc + 1);
  asm volatile ("int $0x80" :: "a" (SYS_exit), "b" (0));
}
