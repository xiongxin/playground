#include "list.h"
#include <assert.h>
#include <stdlib.h>

#include "common.h"

int main(int argc, char const *argv[]) {
  LIST_HEAD(testlist);
  INIT_LIST_HEAD(&testlist);

  assert(list_empty(&testlist));

  struct listitem *item, *is = NULL;
  item = (struct listitem *)malloc(sizeof(*item));
  item->i = 1;
  list_add_tail(&item->list, &testlist);
  assert(list_empty(&testlist));

  return 0;
}
