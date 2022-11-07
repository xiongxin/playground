typedef unsigned long size_t;

size_t
my_strlen(const char *p)
{
  size_t ret;
  for (ret = 0; p[ret]; ++ret)
    ;
  return ret;
}
