#include <stdlib.h>

typedef struct list_entry {
  int value;
  struct list_entry *next;
} list_entry_t;

void append(int value, list_entry_t **head) {
  list_entry_t **indirect = head;

  list_entry_t *new = malloc(1 * sizeof(list_entry_t));
  new->value = value, new->next = NULL;

  while (*indirect) {
    indirect = &((*indirect)->next);
  }

  *indirect = new;
}

int main(int argc, char const *argv[]) {
  list_entry_t *l = malloc(1 * sizeof(list_entry_t));
  append(1, &l);
  return 0;
}
