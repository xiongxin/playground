#include <sys/syscall.h>

typedef unsigned long size_t;

int my_write(int, const void *, size_t);

static size_t
my_strlen(const char *p)
{
  size_t ret;
  for (ret = 0; p[ret]; ++ret)
    ;
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
