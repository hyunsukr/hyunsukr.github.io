/* do not remove these definitions or replace them #includes */
#define NULL 0
typedef long size_t;
void *malloc(size_t size);
void *realloc(void *ptr, size_t size);
void free(void* ptr);
int printf(const char *format, ...);

/* The following #ifdef and its contents need to remain as-is. */
#ifndef TYPE
#define TYPE short
TYPE sentinel = -1234;
#else
extern TYPE sentinel;
#endif

/* typedefs needed for this task: */
typedef struct range_t { 
  unsigned int length; 
  TYPE *ptr; 
} range;

TYPE *convert(range list) {
  TYPE *x;
  int size = list.length;
  x = malloc(sizeof(TYPE)*(size+1));
  for(int i =0; i<size; i++) {
    x[i] = list.ptr[i];
  }
  x[size] = sentinel;
  return x;
}
void append(TYPE **dest, TYPE *source) {
  int size_s = 0;
  for(int i =0; source[i] != sentinel; i++) {
    size_s++;
  }
  int size_dest = 0;
  for(int i =0; (*dest)[i] != sentinel; i++) {
    size_dest++;
  }
  int full_size= size_dest + size_s;
  *dest = realloc(*dest, sizeof(TYPE) * (full_size + 1));
  for(int i = size_dest; i < full_size; i++) {
    (*dest)[i] = source[i-size_dest];
  }
  (*dest)[full_size] = sentinel;
  return;
}
void remove_if_equal(TYPE **dest, TYPE value) {
  int numremove = 0;
  for(int i =0;(*dest)[i] != sentinel; i++ ) {
    if ((*dest)[i] == value) {
      numremove++;
    }
  }
  int size_dest = 0;
  for(int i =0; (*dest)[i] != sentinel; i++) {
    size_dest++;
  }
  int pos = 0;
  while((*dest)[pos] != sentinel) {
    if((*dest)[pos] == value) {
      int j = pos;
      for(j;j<size_dest;j++) {
        (*dest)[j] = (*dest)[j+1];
      }
    }
    if((*dest)[pos] == value) {
      pos = pos -1;
    }
    pos++;
  }
  *dest = realloc(*dest, sizeof(TYPE) * ((size_dest - numremove) + 1));
}
