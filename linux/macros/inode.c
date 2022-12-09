#include <stdio.h>

#define cons(x, y)                                                             \
  (struct llist[]) { x, y }

struct llist {
  int val;
  struct llist *next;
};

int main() {
  struct llist *list = cons(4, cons(7, NULL));
  struct llist *p = list;
  for (; p; p = p->next)
    printf("%d", p->val);
  printf("\n");
  return 0;
}
