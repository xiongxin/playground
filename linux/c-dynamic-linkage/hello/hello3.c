#include <dlfcn.h>
#include <sys/syscall.h>

const char greeting[] = "hello world\n";
int
main(int argc, char **argv, char **envp)
{
  size_t (*my_strlen)(const char *p);
  int (*my_write)(int, const void *, size_t);

  void *handle = dlopen("dest/libmy.so", RTLD_LAZY);
  if (!handle
      || !(my_strlen = dlsym(handle, "my_strlen"))
      || !(my_write = dlsym(handle, "my_write")))
    return 1;

  my_write (1, greeting, my_strlen(greeting));
  return 0;
}

void
__libc_start_main(int (*mainp)(int, char **, char **),
		  int argc, char **argv)
{
  mainp(argc, argv, argv + argc + 1);
  asm volatile ("int $0x80" :: "a" (SYS_exit), "b" (0));
}
