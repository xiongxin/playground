#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

typedef struct State State;
struct State {
  int c;
  State *out;
  State *out1;
  int lastlist;
};

typedef union Ptrlist Ptrlist;

union Ptrlist {
  Ptrlist *next;
  State *s;
};

int main() {
  State *s = (State *)malloc(sizeof(State));
  s->c = 100;
  State **sp = &s;
  Ptrlist *l = (Ptrlist *)sp;
  printf("%p %d\n", (void *)(l->s), l->s->c);
  l->next = NULL;
  // printf("%d\n", s->c);
  free(s);
}
