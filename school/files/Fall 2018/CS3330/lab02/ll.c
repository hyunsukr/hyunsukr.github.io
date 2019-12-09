#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "ll.h"

/* For a description of what the functions in this file are supposed to do,
   read ll.h
*/

static void give_up_on_malloc_error() {
  fprintf(stderr, "allocating memory failed!\n");
  abort();
}

ll_node *ll_new() {
  ll_node *new_node = malloc(sizeof(ll_node));
  if (!new_node) give_up_on_malloc_error();
  new_node->next = new_node->prev = new_node;
  new_node->value = NULL;
  return new_node;
}

void ll_free(ll_node *root) {
  ll_node *cur = root->next;
  while (cur != root) {
    cur = cur->next;
    free(cur->prev->value);
    free(cur->prev);
  }
  free(root->value);
  free(root);
}


ll_node *ll_add_after(ll_node *new_prev, const char *new_value) {
  ll_node *new_node = malloc(sizeof(ll_node));
  if (!new_node) give_up_on_malloc_error();
  new_node->value = malloc(strlen(new_value)+1);
  if (!new_node->value) give_up_on_malloc_error();
  strcpy(new_node->value, new_value);
  new_node->next = new_prev->next;
  new_node->prev = new_prev;
  new_node->next->prev = new_node;
  new_node->prev->next = new_node;
  return new_node;
}

ll_node *ll_add_before(ll_node *new_next, const char *new_value) {
  return ll_add_after(new_next->prev, new_value);
}

void ll_remove(ll_node *node) {
  node->prev->next = node->next;
  node->next->prev = node->prev;
  free(node->value);
  free(node);
}

void ll_replace(ll_node *node, const char *new_value) {
  free(node->value);
  node -> value = malloc(strlen(new_value)+1);
  strcpy(node->value, new_value);
}

void ll_move_after(ll_node *node, ll_node *new_prev) {
  node->prev->next = node->next;
  node->next->prev = node->prev;
  node->prev = new_prev;
  node->next = new_prev->next;
  node->next->prev = node;
  node->prev->next = node;
}

ll_node *ll_copy_list(ll_node *root) {
  ll_node *new_root = ll_new();
  ll_node *new_cur = new_root;
  ll_node *old_cur = root->next;
  while (old_cur != root) {
    new_cur = ll_add_after(new_cur, old_cur->value);
    old_cur = old_cur->next;
  }
  return new_root;
}

void ll_print(ll_node *root) {
  int i = 0;
  ll_node *cur = root->next;
  while (cur != root) {
    printf("node #%d: value=[%s]\n", i, cur->value);
    i += 1;
    cur = cur->next;
  }
}
